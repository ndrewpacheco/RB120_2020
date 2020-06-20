require "pry"

# Twenty-One is a card game consisting of a dealer and a player,
# where the participants try to get as close to 21 as possible without going over.

# Here is an overview of the game:
# - Both participants are initially dealt 2 cards from a 52-card deck.
# - The player takes the first turn, and can "hit" or "stay".
# - If the player busts, he loses. If he stays, it's the dealer's turn.
# - The dealer must hit until his cards add up to at least 17.
# - If he busts, the player wins. If both player and dealer stays, then the highest total wins.
# - If both totals are equal, then it's a tie, and nobody wins.

class Participant

  attr_accessor :cards
  def initialize

    @cards = []
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def show_cards
    cards.map do |card|
      "  #{card}"
    end.join("\n").to_s
  end

  def total
    score = 0

    cards.each do |card|
      score += Game::CARD_RANKING[card.value] unless card.value == :ace
    end

    cards.each do |card|
      if card.value == :ace
        score += if score < 11
                   11
                 else
                   1
                 end
      end
    end
    score
  end

  def busted?
    total > 21
  end

  def show_busted
    puts "You busted!"
  end

  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Player < Participant

  def show_total
    puts ''
    puts "Your score is #{total}"
    puts ''

  end

  def hit_or_stay
    answer = nil
    loop do
      puts 'Would you like to hit or stay? (h/s)'
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)
      puts 'Not a valid answer'
    end
    answer
  end
end

class Dealer < Participant

end

class Deck
  SUITS = [:diamonds, :clubs, :spades, :hearts]
  VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]

  attr_reader :cards

  def initialize

    @cards = []
    SUITS.each do |suit|

      VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
      @cards.shuffle!
    end
    #array of all cards
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?

    # array of all cards
  end

  def deal(participant)
    new_card = cards.pop
    participant.cards << new_card
    new_card
    # does the dealer or the deck deal?
  end
end

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    # what are the "states" of a card?
    @suit = suit
    @value = value
  end

  def to_s
    "#{value.capitalize} of #{suit.capitalize}"
  end
end

class Game

  CARD_RANKING = Deck::VALUES.map do |val|
    if val == :ace
      [val, [1, 11]]
    elsif [:jack, :queen, :king].include?(val)
      [val, 10]
    else
      [val, Deck::VALUES.index(val) + 2]
    end
  end.to_h

  attr_reader :deck, :player, :dealer
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new

  end

  def greeting
    system 'clear'
    puts ""
    puts "Welome to 21!"
    puts ""
  end
  def deal_cards
    # player gets two cards
    # comp gets two cards
    deck.deal(player)
    deck.deal(player)
    deck.deal(dealer)
    deck.deal(dealer)
  end

  def show_cards
    puts "-----------------"
    puts "Player's cards: "
    puts player.show_cards
    puts ''
    puts "Dealer's cards: "
    puts "  #{dealer.cards[0]} and an unknown card"
  end

  def dealer_turn
    return nil if player.busted?
    loop do
      deck.deal(dealer)
      break if dealer.total >= 17
    end
  end

  def player_turn
    loop do
      show_cards
      player.show_total
      answer = player.hit_or_stay
      deck.deal(player) if answer == 'h'
      break if answer == 's' || player.busted?
    end
  end

  def show_scores
    puts "Player's score: #{player.total}"
    puts "Dealer's score: #{dealer.total}"
  end

  def show_winner
    if player.total > dealer.total
      puts 'You won!'
    elsif player.total < dealer.total
      puts 'Dealer won'
    else
      puts 'its a tie'
    end
  end

  def show_result
    return puts 'You busted! Dealer won' if player.busted?
    return puts 'Dealer busted! You won' if dealer.busted?

    show_scores
    show_winner
  end

  def start
    deal_cards
    greeting
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start
