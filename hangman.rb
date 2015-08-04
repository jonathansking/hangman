class Game
  def initialize
    @word = ""
    @correct_letters = []
    @incorrect_guesses = []
    @incorrect_guesses_remaining = 10
    @dict = File.open("5desk.txt", "r")
  end

  def start_game
    select_word
    before_game
    until game_over?
      display_guesses_and_letters
      next_guess
    end
    display_win_lose
  end

  def select_word
    candidates = @dict.readlines.select do |line|
      line.strip.length > 4 && line.strip.length < 13
    end
    @word = candidates.map { |s| s.strip }.sample
    @word.downcase!
    @dict.close
  end

  def before_game
    puts "-----------------------"
    puts "Hangman"
    puts "-----------------------"
  end

  def display_guesses_and_letters
    puts "\nIncorrect guesses remaining: #{@incorrect_guesses_remaining}"
    @word.each_char { |c| print "_ "}
    puts "\n\nIncorrect guesses: #{@incorrect_guesses.join(" ")}"
  end

  def next_guess
    puts "\nChoose a letter:"
    letter = gets.chomp.downcase!
    check_guess
  end

  def check_guess

    @incorrect_guesses_remaining -= 1 unless guess_correct?
  end

  def guess_correct?
  end

  def save_game
  end

  def load_game
  end

  def game_over?
    #return @word == @correct_letters ? true : false
  end

  def display_win_lose
  end
end

game = Game.new.start_game
