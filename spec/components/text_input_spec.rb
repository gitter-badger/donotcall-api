require 'spec_helper'
require 'text_input'

RSpec.describe TextInput do
  let(:klass) { TextInput }

  it 'is valid when valid input is given' do
    valid_input = '7248380940' 
    expect(TextInput.new(valid_input).valid?).to eq(true)
  end

  it 'is not valid when invalid input is given' do
    invalid_input = '724-838-0940' 
    expect(TextInput.new(invalid_input).valid?).to eq(false)
  end
end


