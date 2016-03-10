require 'do_not_call_list'

class CheckNumbers
  include ActiveModel::Validations

  attr_reader :numbers, :extras

  validate :validates_numbers_present
  validate :validates_extras_present

  def initialize(args)
    @numbers = args.fetch(:numbers, [])
    @extras  = args.fetch(:extras, {})
    @do_not_call_list = DoNotCallList.new
  end

  def perform
    return false unless valid?
    results = [] 
    numbers.map {|number| results << check_number(number) }
    results
  end

  protected

  def check_number(number)
    query = ListQuery.new(input: number)
    query.check_list!(@do_not_call_list)
  end

  def validates_numbers_present
    errors.add(:numbers, "are required") unless !numbers.blank? #&& numbers.length >= 1
  end
  
  def validates_extras_present
    #errors.add(:base, "IP Address must be present in extras") unless extras.key?(:ip_address)
  end 
end
