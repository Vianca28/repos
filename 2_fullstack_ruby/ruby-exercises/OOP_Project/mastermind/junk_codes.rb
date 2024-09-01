module Mastermind

  #1- white, 2 red, 3 0range, 4 yellow, 5 green, 6 blue, 7 indigo, 8 violet

  class Game
    def initialize
      
      @guess_board = Array.new(12) { Array.new(4) }
      @result_board=Array.new(12) { Array.new(4) } 

      @set_code=Array.new(4)
      @guess_code=Array.new(4)
      @turn_count=13

      @code_match= false
      
     mode_selection
     set_mode

     @not_match=[]
      @match_number=[]
     play
        
    end
    attr_reader :guesser_id

    def no_match(value)
      @not_match<<value
    end

    def matched(value)
      @match_number<<value
    end

    def welcome
      puts "Welcome to the Mastermind game! \n\n"
      loop do
      puts "1: What's Mastermind?\n"
      puts "2: How to play the Mastermind?\n"
      puts "3: Start the game?\n\n"
      puts "Please pick a number from the option: "
      pick = gets.to_i
        return pick if pick.between?(1,3)       
          puts "Invalid input. Press 1, 2, or 3 only!\n"      
        end
    end

    def mode_selection
      loop do
       puts "Choose a Game Mode: \n"
 
       puts "1 for Setter \n"            
       puts "2 for Guesser \n"
       puts "3 for Random \n"

       @playermode=gets.to_i 
       return @playermode if @playermode.between?(1,3)       
       puts "Invalid input. Press 1, 2, or 3 only!\n"      
      end      
    end  

    def players_assign(setter, guesser)     
      @guesser_id = 1
      @players = [setter.new(self, "Setter"), guesser.new(self, "Guesser")]
    
    end

    def guessing   
      @players[@guesser_id]
    end

    def set_mode
      case @playermode
      when 1 then setter
      when 2 then guesser
      when 3 then random_set
     end    
    end

    def setter
      #computer 1, Human 0     
      players_assign(Human, Computer)   
        
        puts "1: White, 2: Red, 3: Orange, 4: Yellow, 5: Green, 6: Blue, 7: Indigo, 8: Violet \n"
         loop do
         puts "Please input your 4 digit coordinates [*:*:*:*]:"    
         code=gets.chomp
         @set_code=code.to_s.split('').map(&:to_i)

          return @set_code if code.length==4 
          puts  "\n"
          puts "Only 4 digit code"
          end      
        
    end

  
    def guesser
     puts "You're a guesser"
    end

    def random_set
    puts "You'll play random'"
    end   

    def play     
      if @turn_count >= 1 && @turn_count <=13
      @turn_count-=1
   
     match_checker(guessing) 
    
     print_result   
     
      check_play
      end
    end

    def check_play
      if @code_match == false
        play
       end
    end   
   
    def match_checker(player)
      counts=12-@turn_count.to_i
    
      if counts == 0
        latest_guess=0
        latest_hint =0
      
      else
        counts-=1
        latest_guess= @guess_board[counts]
        latest_hint=@result_board[counts]
      end
     #puts "#{count}: #{latest_guess} and #{latest_hint}"
     guess = player.my_guess!(latest_guess, latest_hint)     
  
     set=@set_code
    
      if set.join() == guess.join()
        puts "Set Code :#{set}   Guess Code: #{guess}"
        puts "Code Match"
        @code_match=true

      else code_checker(set, guess)      
      end  
    
    end

    def code_checker(set,guess)
      set= set
      guess= guess
       
      counts =0
      @code_result =["X","X","X","X"]

      @code_match=false

      #matching code pattern 1 = match, 2 present, 3, does not match
          
        set.each_with_index do|set_data, set_index|
          guess.each_with_index do |guess_data, guess_index|
            if set_data == guess_data

              if set_index == guess_index       
                @code_result.delete_at(guess_index)
                @code_result.insert(guess_index, "/")

              elsif set_index != guess_index    
                set_count=set.count(guess[guess_index])   
                guess_count=guess.count(guess[guess_index])

                if set_count >= 1 && guess_count <= set_count
                  @code_result.delete_at(guess_index)
                  @code_result.insert(guess_index, "*")       
                end                   
              end   
            end
          end
        end  
        #puts "#{@code_result} and #{guess}"
        collect_to_board(@code_result, guess)
      
    end
   

    def collect_to_board(code, guess)
      board_index=12-@turn_count.to_i
     if board_index<=11
     code.each_with_index do |code_data, code_index|
    
      @result_board[board_index][code_index]=code_data    
     end
     guess.each_with_index do |guess_data, guess_index|
      @guess_board[board_index][guess_index]=guess_data
     end     
    end
   
    end

    def print_result
    counts = 12-@turn_count.to_i      
       
    guess=@guess_board[counts]   
      
       result=@result_board[counts]          
      if counts<=11
       if guess.join()!="" && result.join()!=""       
         puts "turn #{counts+1}: [#{guess.join(":")}] => [#{result.join(":")}]"      
       end
    end
     end 
  end

  class Player
    def initialize(game, playing)
      @game= game
      @playing=playing
    end
  end

  class Human < Player
    def my_guess!
      code =Array.new(4) { rand(1..8) }
      @guess_code= code.to_s.split(',').map(&:to_i)      
     return code
    end

    def to_s
      "Human"
    end

  end

  class Computer < Player
    def my_guess!(guess,hint)      
      guess=guess
      hint=hint
      @not_match=@not_match
      @match_number=@match_number
      
      #puts "#{guess} and #{hint}"
     
      if guess==0 && hint ==0
        
        #add the code result comparison, and the loop for 12
        code = 2,3,4,6
        #Array.new(4) { rand(1..8).join(',') }
        @guess_code= code
        # code.to_s.split(',').map(&:to_i)  
    
       else
        #interpret the hint       
          new_guess=Array.new(4)            

          hint.each_with_index do |hint_data, hint_index|        
            guess.each_with_index do |guess_data, guess_index|  
              sign=hint[hint_index]
              set=@set_code            
              
              
              if sign=='/'              
                 new_guess[hint_index]=guess[hint_index] 
                
                if @match_number==nil
                  @match_number.push(guess[hint_index])
                else 
                  if !@match_number.include?(guess[hint_index])
                    @match_number.push(guess[hint_index])
                  end
                end             
              
              elsif sign=='*'  
                  if @match_number==nil
                   @match_number.push(guess[hint_index])
                  else 
                    if !@match_number.include?(guess[hint_index])
                      @match_number.push(guess[hint_index])
                    end
                  end                           
                  i=0 
                  while hint[i]!='/' && i<=3 && i!=hint_index 
                        new_guess[i]=guess[hint_index] 
                    i+=1               
                  end #while

                else 
                  if @not_match==nil
                   @not_match.insert(0,guess[hint_index])
                  else
                    if !@not_match.include?(guess[hint_index])
                     @not_match.push(guess[hint_index])
                    end
                  end                 
                end #if elsif                  
                
            end #guess           
          end  #hint      
          i=0                         
                  while i<=3  
                    puts "#{@not_match}" 
                    if new_guess[i]==nil                      
                    new_guess_digit=rand(0..8)                                      
                    if !@not_match.include?(new_guess_digit)
                      new_guess[i]=new_guess_digit                    
                    else 

                    while @not_match.include?(new_guess_digit)
                      new_guess_digit=rand(0..8)     
                     
                    end                  
                    new_guess[i]=new_guess_digit   
                  end
                  
                  end #while   
                  i+=1                                     
                 end               
          @guess_code= new_guess 
      end #if  
    
     return @guess_code
     #def
    end

    def to_s
      "Computer"
    end

  end
end


include Mastermind
Game.new

