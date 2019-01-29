class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    
    @a = [] 
    @c = []
    
    @num = 0
    @wordwith = []
    @charnum = 0
  end
  attr_accessor:word ,:guesses, :wrong_guess, :win, :lose, :play
  
  def guess(char)
    if char =='' || /[A-Za-z]/ !~ char || char == nil
      raise ArgumentError
    end
    
    char = char.gsub(/[\s,]/,"")
    
    @charnum = char.chars.count

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
