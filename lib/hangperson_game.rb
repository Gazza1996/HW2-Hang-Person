# Author: Gary Mannion

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
    def initialize(word)
        @word = word
        @a = [] # wrong guess
        @c = [] # correct guess
        @num = 0
        @word_with = []
        @charNum = 0
    end
    attr_accessor :word ,:guesses , :wrong_guesses , :win , :lose , :play
    
    def guess(char)
        # check char
        if  char == '' || /[A-Za-z]/ !~ char || char == nil
            raise ArgumentError
        end
        
        char = char.gsub(/[\s,]/ ,"") # spaces/commas
        
        @charNum = char.chars.count
       
        char.chars.each do |l|
            # correct and not repeated
            if @word.include?(l) && ((@c.include? l) == false)
                @c.push(l)
            # correct, repeated or already guessed
            elsif (@word.include?(l) && ((@c.include?(l)) == true)) || ((@a.include?(l)) == true)
                    return false
            # already guessed or wrong
            elsif ((@a.include?(l)) == true) || ((('A'..'Z') === l)) || (((@c.include?(l) == true)))
                    return false
            # not already in wrong guessed         
            elsif   @a.include?(l) == false && @c.include?(l) == false
                    @a.push(l)
                    
            end
        end
            @wrong_guesses =  @a.join.to_s
            @guesses = @c.join.to_s
    end
    
    def word_with_guesses
        if @num == 0
            @word.chars.each do |l|
                @word_with.push("-")
            end
            @num = 1
        end
        
        # check if gussed chars match the word
        a= @word.chars
        b=@c.join.to_s
        for i in 0..b.size - 1
            for j in 0..@word.size
                if b[i] == a[j]
                    @word_with[j] = a[j]
                end
            end
        end
        
       @word_with.join.to_s
    
    end
    
    # win/lose
    def check_win_or_lose
        if word_with_guesses == @word
            :win
            elsif @wrong_guesses.chars.count >= 7
            :lose
            else
            :play
        end
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