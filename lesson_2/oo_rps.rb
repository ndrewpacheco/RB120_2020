class Player
  attr_accessor :move
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    # maybe a "name"? what about a "move"?
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose: Rock, Paper, Scissors"
        choice = gets.chomp.downcase
        break if %w(rock paper scissors).include? choice
        puts "Try again"
      end
      self.move = choice
    else
      self.move = %w(rock paper scissors).sample
    end
  end

  def human?
    @player_type == :human
  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to RPS"
  end

  def display_goodbye_message
    puts "Goodbye!"
  end

  def display_winner
    puts "You chose #{human.move}"
    puts "The computer chose #{computer.move}"
  end
  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play