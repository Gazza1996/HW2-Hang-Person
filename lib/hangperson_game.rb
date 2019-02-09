# Author: Gary Mannion

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  # keywords
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :incorrect_guesses
  attr_accessor :check_win_or_lose
  
  # function
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @guess = ''
    @word_with_guesses = ''
    @check_win_or_lose = :play
    
    for i in 1..word.length do
      @word_with_guesses.concat('-')
    end
  end # def
  
  
  # A method that takes in a letter and checks to see if its inside the word
  def guess(guessedLetter)
    
    # Raise exceptions if the following cases occur
    if(guessedLetter.nil?)
      raise ArgumentError.new("Invalid guess.")
    end

    if(guessedLetter == '')
      raise ArgumentError.new("Invalid guess.")
    end

    if(guessedLetter[/[a-zA-Z]/] != guessedLetter)
      raise ArgumentError.new("Invalid guess.")
    end

    # lowercase
    guessedLetter.downcase!
 
    # not guessed already
    if(word.include? guessedLetter)
      unless (guesses.include? guessedLetter)

        # add to list of guessed
        guesses.concat(guessedLetter)
        #
        for i in 0..word.length do
          if(guessedLetter == word[i])
            word_with_guesses[i] = guessedLetter
          end
        end
        #
        if(word_with_guesses == word)
          @check_win_or_lose = :win
        end
        return true
      end
    return false
    # guess not added yet
    else
      unless (wrong_guesses.include? guessedLetter)
        wrong_guesses.concat(guessedLetter)
        # 7 guesses at a word before losing
        if(@wrong_guesses.length>=7)
          @check_win_or_lose = :lose
        end
        return true
      end
    end
    return false
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end