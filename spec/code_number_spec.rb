require 'code_number'

describe CodeNumber do
  context '#generate_code' do
    it 'generates a 4 digit code' do
      expect( CodeNumber.generate_code.size ).to eq 4
    end
    it 'all its digits are different' do
      expect(CodeNumber.generate_code.chars.uniq.size).to eq 4
    end
    it 'first digit shoul not be 0' do
      expect(CodeNumber.generate_code[0]).not_to eq '0'
    end
  end
end
