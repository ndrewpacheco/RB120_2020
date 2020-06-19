require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    reset
  end

  def draw

    puts '     |     |'
    puts '  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}'
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts '  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}'
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts '  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}'
    puts '     |     |'
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked?}
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def detect_winner
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

# sq
class Square
  INITIAL_MARKER = ' '.freeze
  attr_accessor :marker
  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

# player
class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

# ttt cgame
class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts 'welcome!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing TTT!'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts 'Youre a #{human.marker}, Computer is #{computer.marker}'
    puts ''
    board.draw
    puts ''
  end

  def human_moves
    puts 'Choose a square between #{board.unmarked_keys.join(', ')}: '
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts 'Invalid answer'
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board
    case board.detect_winner
    when HUMAN_MARKER then puts 'You won'
    when COMPUTER_MARKER then puts 'computer won'
    else puts 'the board is full'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'sorry Invalid answer'
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
    puts "let's play again!"
    puts ''
  end

  def play
    display_welcome_message
    clear
    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
