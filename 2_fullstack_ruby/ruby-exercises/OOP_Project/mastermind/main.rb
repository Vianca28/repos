require_relative 'lib/game'

system("clear")

puts("Welcome to Mastermind!".colorize(:red))
puts("Options")


user_choice=0

loop do until user_choice == 3

    puts("1. What's Mastermind?")
    puts("2. How to play Mastermind?")
    puts("3. Start the game!")

user_choice=gets.chomp.to_i

until user_choice == 1 || user_choice == 2 || user_choice ==  3
puts("Please input the number of your choice")
user_choice=gets.chomp.to_i
end

if user_choice == 1
  puts("1. What's Mastermind?".colorize(:blue))
  puts("Mastermind game is...")

  puts("Click any key to continue\n")
  to_continue=gets.chomp

elsif user_choice == 2
  puts("2. How to play Mastermind?".colorize(:blue))
  puts("Click any key to continue\n")
  to_continue=gets.chomp

elsif user_choice == 3
  puts("3. Start the game!".colorize(:blue))
      loop do
        puts "Choose a Game Mode: \n"
    
        puts "1 for Setter \n"            
        puts "2 for Guesser \n"
        puts "3 for Random \n"
    
        @playermode=gets.to_i 
        break if @playermode.between?(1,3)       
        puts "Invalid input. Press 1, 2, or 3 only!\n"      
       end    
    end
    setter= Computer
    guesser= Human
  
    if @playermode == 1
      setter= Human
      guesser= Computer
      puts("Setter: #{setter}")
  
  
    elsif @playermode == 2
      setter= Computer
    guesser= Human
      puts("Setter: #{setter}")
    
    elsif @playermode == 3
      player=rand(0,1)
  
      if player == 0
        setter= Human
      guesser= Computer
      else 
        setter= Computer
        guesser= Human
      end
      puts("Setter: #{setter}")
    end

    game= Game.new(setter,guesser)
  
 end
  
 end