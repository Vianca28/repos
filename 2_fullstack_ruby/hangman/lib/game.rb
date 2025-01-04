# Game logic # rubocop:disable Style/FrozenStringLiteralComment
class Game
  def initialize
    @word = pick_word
    @word_clues = ''
    @word.length.times { @word_clues << '_' }
    @guessed = []
    @guesses = 10
  end

  def request_guess
    display
    guess = prompt_guess

    return 'save' if guess.downcase == 'save'

    validate_guess(guess)
    enter_guess(guess.downcase)
  rescue StandardError => e
    puts "\n#{e}"
    retry
  end

  def over?
    if @word == @word_clues
      print 'Your guess is correct: '
      puts "\"#{@word}\"\n"
      true
    elsif @guesses.zero?
      print "You couldn't guess the word: "
      puts "\"#{@word}\"\n"
      true
    end
  end

  private

  def prompt_guess
    print "\nEnter a letter, or type save to save progress: "
    gets.chomp
  end

  def validate_guess(guess)
    return if guess.downcase == 'save'

    raise "Invalid input: #{guess}" unless valid_input?(guess)
    raise "You've already guess that letter!" if already_guessed?(guess)
  end

  def valid_input?(guess)
    /[[:alpha:]]/.match(guess) && guess.length == 1
  end

  def already_guessed?(guess)
    @guessed.include?(guess) || @guessed.include?(guess)
  end

  def enter_guess(char)
    if @word.include?(char)
      @guessed << char
      add_clue(char)
      puts "\nGood guess!"
    else
      @guessed << char
      @guesses -= 1
      puts "\nBad guess!"
    end
  end

  def display
    if @guesses < 10
      print 'Letters guessed: '
      @guessed.each { |guess| print guess }
      puts
    end

    display_remaining_guesses

    puts @word_clues
  end

  def display_remaining_guesses
    if @guesses == 1
      puts "LAST CHANCE!!!\n"
    elsif @guesses < 4
      puts "Guesses remaining: #{@guesses}\n"
    elsif @guesses < 6
      puts "Guesses remaining: #{@guesses}\n"
    else
      puts "Guesses remaining: #{@guesses}\n"
    end
  end

  def add_clue(char)
    @word.chars.each_with_index do |c, i|
      @word_clues[i] = char if c == char
    end
  end

  def pick_word
    dictionary = File.open('words.txt', 'r')
    words = []

    dictionary.each_line do |line|
      line = line.chomp
      words << line if line.length > 5 && line.length < 12 && /[[:lower:]]/.match(line[0])
    end

    dictionary.close
    words.sample
  end
end