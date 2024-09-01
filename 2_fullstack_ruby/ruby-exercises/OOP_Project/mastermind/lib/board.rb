class Board
  
  def initialize(turn_counts, guess_code)
    @guess_board = Array.new(12) { Array.new(4) }
    @result_board=Array.new(12) { Array.new(4) } 

    create_board(turn_counts)

  end

  def set_the_code(player)
    player_choices = player.get_set_code
    
    @secret_row = player_choices    
  end

  def create_board(turn_counts)
     turn_counts.times {"[_:_:_:_] = [_:_:_:_] "}
  end

end