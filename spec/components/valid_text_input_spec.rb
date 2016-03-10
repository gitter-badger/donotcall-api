require 'spec_helper'
require 'valid_text_input'

RSpec.describe ValidTextInput do
  let(:klass) { ValidTextInput }
  let(:valid_input) { '7248380940' }

  context 'valid input' do
    it 'is a 10-digit string of numbers only' do
      expect(klass.new(valid_input).valid?).to eq(true)      
    end
  end

  context 'invalid input' do
    [nil, '', '724838094', '72483809401', 'stuff', 'foo123', '724-838-0940'].each do |word| 
      it "#{word} is not valid input" do
        expect(klass.new(word).valid?).to eq(false) 
      end
    end
  end
end
