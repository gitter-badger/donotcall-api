class ValidTextInput

  def initialize(input)
    @raw = input
  end

  def valid?
    if /\A[\d]{10}\z/ =~ @raw
      true
    else 
      false
    end
  end
end
