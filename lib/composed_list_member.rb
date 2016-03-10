class ComposedListMember

  attr_reader :area_code, :local_part

  def initialize(area_code, local)
    @area_code = area_code
    @local_part = local
  end

  def compose
    @composed ||= ListMember.new(number: "#{area_code}#{local_part}")
  end
end
