class Game
  def initialize
    @word = ""
    @correct_letters = []
    @incorrect_letters = []
    @incorrect_guesses_remaining = 10
    @dict = File.open("5desk.txt", "r")
  end

  def start_game
    select_word
    puts @word
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
    display_letters
    puts "\n\nIncorrect guesses: #{@incorrect_letters.join(" ")}"
  end

  def display_letters
    @word.each_char { |c| print @correct_letters.include?(c) ? c + " " : "_ " }
  end

  def next_guess
    puts "\nChoose a letter:"
    letter = gets.chomp
    letter.downcase!
    check_guess(letter)
  end

  def check_guess(letter)
    if guess_correct?(letter)
      @correct_letters << letter
    else
      @incorrect_letters << letter
      @incorrect_guesses_remaining -= 1
    end
  end

  def guess_correct?(letter)
    @word.include?(letter)
  end

  def save_game
  end

  def load_game
  end

  def game_over?
    win? || lose?
  end

  def win?
    @word.split("").uniq.length == @correct_letters.length
  end

  def lose?
    @incorrect_guesses_remaining == 0
  end

  def display_win_lose
    display_letters
    puts win? ? "\n\nYou win!" : "\n\nYou lose!"
  end
end

game = Game.new.start_game
