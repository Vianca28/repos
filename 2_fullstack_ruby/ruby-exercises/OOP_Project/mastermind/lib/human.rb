class Human < Player
  
  def get_set_code
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

  def to_s
    "Human"
  end
end