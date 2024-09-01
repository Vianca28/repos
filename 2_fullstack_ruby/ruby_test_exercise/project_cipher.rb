
def get_input
  #asks user to input word to encrypt
  print "Word to Encrypt: "
  to_encrypt=gets.chomp

  print "Your shift key:"
  shift_key=gets.chomp.to_i

  caeser_cipher(to_encrypt, shift_key)
end


def caeser_cipher(to_encrypt, shift_key)

  final_encryption=""

  #convert each character of the word to encrypt to integer
  #.ord returns the ASCII value of the character
  #A =65, B= 66..., Y =89, Z=90
  #a=97..z=122
  
 to_encrypt.each_char do |char|
   #check for case (lowercase)
   if char.ord.between?(97,122)       
      encrypted_char = (char.ord - 97 + shift_key)%26 + 97
        final_encryption +=encrypted_char.chr
   
   elsif char.ord.between?(65,90)
   
      encrypted_char = (char.ord - 65 + shift_key)%26 + 65
        final_encryption +=encrypted_char.chr
      
    else
      final_encryption+=char
    end  
  end
  p final_encryption 
end
    
get_input
