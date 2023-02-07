require 'code_number'

describe CodeNumber do
  context '#generate_code' do
    it 'generates a 4 digit code' do
      expect( CodeNumber.generate_code.size ).to eq 4
    end
    it 'all its digits are different' do
      expect(CodeNumber.generate_code.chars.uniq.size).to eq 4
    end
  end
end
