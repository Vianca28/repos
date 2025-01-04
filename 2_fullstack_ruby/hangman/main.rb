# The main entry point # rubocop:disable Style/FrozenStringLiteralComment

require_relative 'lib/game'

require 'yaml'
require 'fileutils'

# utility function
def check_saves_dir
  FileUtils.mkdir_p('saved_games')
end

def save_game(game_state)
  check_saves_dir

  save_file = prompt_save_game
  return false unless save_file

  dump = YAML.dump(game_state)
  File.write(File.join(Dir.pwd, "saved_games/#{save_file}.yaml"), dump)
  true
end

def prompt_save_game
  save_files = Dir.glob('saved_games/*').map { |file| File.basename(file, '.yaml') }

  save_file = nil
  until valid_save_file?(save_file, save_files)
    puts 'Enter a name for your game save:'
    save_file = gets.chomp
    handle_existing_file(save_file) if save_files.include?(save_file)
  end

  save_file
end

def valid_save_file?(save_file, save_files)
  save_file && (!save_files.include?(save_file) || gets[0].chomp.downcase == 'y')
end

def handle_existing_file(save_file)
  puts "#{save_file} already exists. Overwrite? (Yes/No)".red
end

def load_game
  load_file = choose_save_file
  saved_file = File.open(File.join(Dir.pwd, load_file), 'r')
  load_game = YAML.safe_load(saved_file, permitted_classes: [Game])
  saved_file.close
  load_game
end

def choose_save_file
  save_files = Dir.glob('saved_games/*').map { |file| File.basename(file, '.yaml') }
  puts 'Here are the current saved games. Select file:'
  puts save_files

  load_file = gets.chomp
  raise "#{load_file} does not exist.".red unless save_files.include?(load_file)

  puts "#{load_file} loaded..."
  "saved_games/#{load_file}.yaml"
end

# Main Program Logic
puts "Welcome to Hangman Game\n"
puts '1) Start a new game'
puts '2) Load a game'

user_choice = gets.chomp
puts
until %w[1 2].include?(user_choice)
  puts 'Invalid input. Please enter 1 or 2'
  user_choice = gets.chomp
end

game = user_choice == '1' ? Game.new : load_game

until game.over?
  next unless game.request_guess == 'save'

  save_game(game)
  puts "\nYour game has been saved. Thanks for playing!"
  break
end