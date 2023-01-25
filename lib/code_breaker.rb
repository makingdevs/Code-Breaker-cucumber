class CodeBreaker

  attr_reader :win, :result
  attr_accessor :attemps, :player

  def initialize(result)
    @result = result.chars
    @attemps = 10
    @player ||= "Default user" 
  end
  def try(guess)
    @attemps -= 1
    digits = @result.intersection(guess.chars)
    attemp = digits.collect {|n| @result.index(n) == guess.chars.index(n) ? "_" : "X"}.sort.join
    @win = attemp == '____'
    attemp 
  end
end
