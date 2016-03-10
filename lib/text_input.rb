require 'valid_text_input'

class TextInput

  def initialize(string)
    @input = string
  end

  def valid?
    return ValidTextInput.new(@input).valid?
  end
end
