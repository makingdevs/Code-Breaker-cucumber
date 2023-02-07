class CodeNumber
  def self.generate_code
    nums = %w(1 2 3 4 5 6 7 8 9 0)
    code = ''
    rand = nums[0..-2].sample
    nums.delete(rand)
    code << rand
    code << nums.sample(3).join
  end
end
