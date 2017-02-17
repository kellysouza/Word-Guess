# Monalisa and Kelly's word guess game
require 'Faker'


class Game
  attr_accessor :word, :letter, :board

  def initialize
    @attempts = 0
    @board = []
    @letter = :letter
    @word = ["happy", "coders"].sample
    puts @word
    @petals = 5
    @guess_letters = []
    @answer_array = []
  end


  def display
    @word.length.times do
      @board << "_"
    end
    print @board
  end

  def get_letter
    puts "Guess the letter:"
    @letter = gets.chomp.downcase
    if @letter.match(/^[a-z]$/)
      puts "valid guess"
      push_guess_letters
      @attempts += 1
      if match_letter
        puts "YES!!"
        modify_board
      else
        puts "NO"
        drop_flower
      end
    else
      puts "invalid: Try again."
    end
  end

  def match_letter
    @answer_array = @word.split("")
    puts @answer_array
    return @answer_array.include?(@letter)
  end


  def drop_flower
    while @petals > 0
      flower = @petals - @attempts
      puts flower
      return flower
    end
  end


  def push_guess_letters
    @guess_letters.push(letter)
    puts @guess_letters
  end

  def modify_board
    puts "HERE"
    puts @answer_array.index{|x|x==@letter}

  end




end
#
#   def make_guess
#     if make_guess = "correct"
# puts ""
# end

game1 = Game.new
game1.display
game1.get_letter
