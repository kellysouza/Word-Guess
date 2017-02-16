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
    else
      puts "invalid"
    end

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
