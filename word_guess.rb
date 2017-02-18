# Monalisa and Kelly's word guess game
require 'colorize'
require 'colorized_string'
require 'rainbow'

class GameLevel
  attr_accessor :easy, :medium, :difficult, :default

  def initialize
    @easy = ["Dog","Cat", "Bear", "zoo"]
    @medium = ["Cake","Book","Smile"]
    @difficult = ["Coconut","Pineapple"]
    @default = ["Dog","Cat","Apple","Bear","Zoo","Coconut","Pineapple","Cake","Book","Smile"]
  end
end

class Game
  attr_accessor :word, :letter, :board

  def initialize
    @attempts = 0
    @board = []
    @letter = :letter
    @petals = 5
    @petals_left = 5
    @guess_letters = []
    @answer_array = []
    @incorrect_attempts = 0
    @imatch = []
    @number_of_hints = 0
    @game_level = GameLevel.new
    pick_word
    create_board
  end

  def pick_word
    puts "Please choose a level: EASY, MEDIUM, DIFFICULT"
    @level = gets.chomp.downcase
    if @level == "easy"
      @word = @game_level.easy.sample.upcase
    elsif @level == "medium"
      @word = @game_level.medium.sample.upcase
    elsif @level == "difficult"
      @word = @game_level.difficult.sample.upcase
    else
      @word = @game_level.default.sample.upcase
    end
  end

  def create_board
    @word.length.times { @board << "_"}
  end

  def display_board
    print @board
  end

  def play_game
    if @petals_left > 0
      show_flower
      display_board
      puts ("\nYou have guessed these letters:
      #{@guess_letters}.").blue
      puts "Please guess a letter or enter the word."
      @letter = gets.chomp.upcase
      check_guess
      if @letter.match(/^[A-Z]$/)
        if find_duplicates
          puts "You already tried that letter!"
          puts "Try again (no penalties)."
        else
          push_guess_letters
          @attempts += 1

          if match_letter
            puts "YES! That letter is in the word!"
            puts "=".green * 60
            modify_board
            check_for_win
          else
            puts "Nope! That letter is not in the word!"
            puts "=".red * 60
            @incorrect_attempts += 1
            drop_flower
          end
        end
      else
        puts "Oops,that is not valid input, please try again.".red
      end
      puts @petal
    end
  end

  def match_letter
    @answer_array = @word.split("")
    return @answer_array.include?(@letter)
  end

    def find_duplicates
      if @guess_letters.include?(@letter)
        return true
      else
        return false
      end
    end

  def hint
    if @number_of_hints < 1
      puts "Hint:"
      hint_indexes = @board.each_index.select{|i| @board[i] == "_"}
      hint_index = hint_indexes.sample
      print @answer_array[hint_index].cyan
      @number_of_hints += 1
    end
  end

  def check_guess
    if @word == @letter
      puts "\nCongratulations, you got all the letters.".green
      show_answer
      show_flower
      puts "You beat Word Guess!!!".green
      exit
    end
  end

  def show_answer
    print Rainbow("The answer was #{@word}!").blue.bg(:white)
    puts
  end

  def check_for_win
    if !@board.include?("_")
      display_board
      puts "\nCongratulations, you got all the letters.".green
      show_answer
      show_flower
      puts "You beat Word Guess!!!".green
      exit
    end
  end

  def show_flower()
    case @petals_left
    when 5
        puts """
        (@)(@)(@)(@)(@)
         ,\\,\\,|,/,/,
            _\\|/_
           |_____|
            |   |
            |___|
     """.green
    when 4
        puts """
        (@)(@)(@)(@)
         ,\\,\\,|,/,/,
            _\\|/_
           |_____|
            |   |
            |___|
     """.green
    when 3
       puts """
       (@)(@)(@)
        ,\\,\\,|,/,/,
           _\\|/_
          |_____|
           |   |
           |___|
       """.yellow
    when 2
        puts """
        (@)(@)
         ,\\,\\,|,/,/,
            _\\|/_
           |_____|
            |   |
            |___|
     """.yellow
    when 1
      hint
       puts """
       (@)
        ,\\,\\,|,/,/,
           _\\|/_
          |_____|
           |   |
           |___|
    """.light_red
    when 0
      puts """
     ,\\,\\,|,/,/,
        _\\|/_
       |_____|
        |   |
        |___|
      """.red

    end
  end

  def drop_flower
    if @petals_left > 1
      @petals_left = @petals - @incorrect_attempts
      # show_flower
      return @petals_left
    else
      @petals_left = 0
      show_flower
      puts "Your flowers are all dead."
      show_answer
      puts "GAME OVER"
      exit
    end
  end

  def push_guess_letters
    @guess_letters.push(@letter)
  end

  def modify_board
    @imatch = @answer_array.each_index.select{|i| @answer_array[i] == @letter}
    # puts @imatch
    @imatch.each do
      |i| @board[i] = @letter
    end
  end
end


#START GAME
no_response = true
while no_response

  puts "Would you like to play Word Guess?"
  play_game = gets.chomp.downcase


  if play_game == "yes"
    game1 = Game.new
    no_response = false
  elsif play_game == "no"
    puts "Ok, come again soon!"
    exit
  else
    puts "Oops, try again"
    puts "Would you like to play Word Guess?"
    play_game = gets.chomp.downcase
  end
end

still_playing = true
while still_playing
  game1.play_game
end
