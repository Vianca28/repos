require_relative 'board'
require_relative 'player'
require_relative 'computer'
require_relative 'human'

require 'colorize'

class Game 
  
  def initialize(setter, guesser)
    system("clear")

    puts "Welcome to the game!"

    @turn_counts=12
    @guess_code
    @board = Board.new(@turn_counts, @guess_code)

    @code_match= false

    @setter_player= setter.new
    @guesser_player= guesser.new

    @board.set_the_code(@setter_player)

    play
  end

  def play
    if @board.won?
      
    elsif game_over? 

    else
      clear_screen
     
    end
  end

end
