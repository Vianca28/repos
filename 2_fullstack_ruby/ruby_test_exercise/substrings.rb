dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings (string, dictionary)
  count={}
  
  string=string.downcase
  
  dictionary.each do |word|
    matches= string.scan(word).length
    count[word] = matches unless matches == 0
  end
  p count

end

substrings("Howdy partner, sit down! How's it going?", dictionary)
