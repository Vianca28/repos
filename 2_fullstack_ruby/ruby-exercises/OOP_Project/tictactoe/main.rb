module TicTacToe
  COMBOS =[[1,2,3], [4,5,6], [7,8,9],
           [1,4,7],[2,5,8],[3,6,9],
           [1,5,9],[3,5,7]]

  class Game 

    def initialize
      @board = Array.new(10) # we ignore index 0 for convenience
        
      mode_selection
      select_piece

      play

   end
   attr_reader :board, :playing_id

    def mode_selection
     loop do
      puts "Choose a Game Mode: \n"

      puts "Press 1 for Vs Computer \n"            
      puts "Press 2 for vs another Player \n"
     
      @playermode=gets.to_i 
      return @playermode if @playermode == 1 || @playermode == 2  
      puts "Invalid input. Press 1 or 2 only!\n"
      end
    end 

   def players_assign(player1, player2)
    ids=[0,1]
    @playing_id = ids.sample
    @players = [player1.new(self, "#{@player1_piece}"), player2.new(self, "#{@player2_piece}")]

    if(@playing_id == 0)
         puts "#{playing} goes first. \n\n"
         else puts "#{playing} goes first.\n\n"
    end   

     puts "Let the games begin! \n\n"
   end

   def select_piece
    loop do
      puts "\n"
      puts "Please choose a piece player 1: \n"
      puts "Press 1 for X \n"
      puts "Press 2 for O \n"

      selected = gets.to_i
    
      if selected == 1 || selected== 2

        if selected == 1 
          @player1_piece ="X"  
          @player2_piece= "O"    

        elsif selected== 2
          @player1_piece ="O"   
          @player2_piece= "X"
        end

        @player1_alias ="Player 1"
        if @playermode ==1 
          player2_alias="Computer"
        else player2_alias = "Player 2"
        end
        
        puts "\n"
        puts "Player 1 piece is #{@player1_piece} and #{player2_alias} piece is #{@player2_piece} \n"    
        #randomize which plays first
      
       if player2_alias == "Computer"
        players_assign(Human, Computer)        
        else players_assign(Human, Human) 
        end  
      return
        else puts "Invalid input. Press 1 or 2 only!\n\n"   
      end     
    end
    end
  
    def playing
    @players[playing_id]
    end

    def opponent
    @players[non_playing_id]
    end

    def non_playing_id
      1 - @playing_id
    end

    def switch_turns
    @playing_id = non_playing_id
    end

  
    def play
    loop do
      place_move(playing)      
      if results?(playing)   
         puts "#{playing} wins!"
        print_board
        return

      elsif full?
        puts "It's a draw."
        print_board
        return
      
      end
      
      switch_turns
     end
    end

    #actual play code
    def place_move(player)
    position = player.player_moves!
  
    puts "#{playing}, positions to #{position} \n"
    @board[position] = player.mark
    
   end
  
    def results?(player)
    COMBOS.any? do |line|
      line.all? {|position| @board[position] == player.mark}
    end
    end

    #board codes
    def turn_count
      10 - openings.size
    end

   def openings
    (1..9).select {|position| @board[position].nil?}
   end

    def full?
    openings.empty?
    end

   def print_board
   
     col_border= " | "
     row_border = "--+---+--"

     position_label = lambda{|position| @board[position] ? @board[position] : position}
      
      display_row = lambda{|row| row.map(&position_label).join(col_border)}
      rows_content = [[1,2,3], [4,5,6], [7,8,9]]
      display_row = rows_content.map(&display_row)
      puts display_row.join("\n" + row_border + "\n")
   end      
  end

  class Player 
    def initialize(game, mark)
      @game = game
      @mark = mark
    end
    attr_reader :mark
  end

  class Human < Player
    def player_moves!
      @game.print_board
      loop do
        print "Player #{mark}, select your #{mark} position: "
        move = gets.to_i
        return move if @game.openings.include?(move)
        puts "Position #{move} is not available. Try again.\n"
      end
    end

      def to_s
        if mark == "X"
          "Player X"    
        else "Player O"      
        end
  
    end
   end

   class Computer < Player
    DEBUG = false
    def group_marks(line)
      marks = line.group_by {|position| @game.board[position]}
      marks.default = []
      marks
    end

    def player_moves!
      computer_marker = @game.opponent.mark
      
      good_positions = available_good_positions(computer_marker)
      return good_positions if good_positions
      
      if defense?
        return defense_position(computer_marker)
      end
      
      # could make this smarter by sometimes doing corner trap offense
      if offense?
        return offense_position(computer_marker)
      end
      return best_position
    end

    def available_good_positions(computer_marker)
      for line in COMBOS
        marks = group_marks(line)
        next if marks[nil].length != 1
        if marks[self.mark].length == 2
          log_debug "winning on line #{line.join}"
          return marks[nil].first
        elsif marks[computer_marker].length == 2
          log_debug "could block on line #{line.join}"
          blocking_position = marks[nil].first
        end
      end
      if blocking_position
        log_debug "blocking at #{blocking_position}"
        return blocking_position
      end
    end

    def defense?
      corner_positions = [1, 3, 7, 9]
      chosen_corner = corner_positions.any?{|pos| @game.board[pos] != nil}
      return @game.turn_count == 2 && chosen_corner
    end
    
    def defense_position(computer_marker)
      # if you respond in the center or the opposite corner, the opponent can force you to lose
      log_debug "defending against corner start by playing adjacent"
      # playing in an adjacent corner could also be safe, but would require more logic later on
      opponent_position = @game.board.find_index {|marker| marker == computer_marker}
      safe_responses = {1=>[2,4], 3=>[2,6], 7=>[4,8], 9=>[6,8]}
      return safe_responses[opponent_position].sample
    end

    def offense?    
      non_corner =[2,4,5,6,8]
      offense_move = non_corner.any?{|pos| @game.board[pos] != nil}
      return @game.turn_count == 2 && offense_move
    end
    
    def offense_position(computer_marker)
      log_debug "offensive move against the opponent"
      opponent_position = @game.board.find_index {|marker| marker == computer_marker}
      safe_responses = {2=>[1,3,5], 5=>[2,4,6,8], 4=>[1,5,7], 8=>[4,5,6] }
      return safe_responses[opponent_position].sample
    end

    
    def best_position
      log_debug "picking random position, favoring center and then corners"
      ([5] + [1,3,7,9].shuffle + [2,4,6,8].shuffle).find do |pos|
        @game.openings.include?(pos)
      end
    end
    
    def log_debug(message)
      puts "#{self}: #{message}" if DEBUG
    end
    
    def to_s
      "Computer"
    end
  end
end


include TicTacToe
Game.new