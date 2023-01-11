class CodeBreaker

  attr_reader :win, :result

  def initialize(result)
    @result = result.chars
  end
  def try(guess)
    digits = @result.intersection(guess.chars)
    attemp = digits.collect {|n| @result.index(n) == guess.chars.index(n) ? "_" : "X"}.sort.join
    @win = attemp == '____'
    attemp 
  end
end
