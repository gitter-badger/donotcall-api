require 'valid_text_input'

class ListQuery < ActiveRecord::Base
  OK = 'not_found_on_list'
  NOT_OK = 'do_not_call'
  ERROR  = 'input_invalid'
  STATUSES = [ OK, NOT_OK, ERROR ]

  #serialize :metadata, Hash

  validates :input, presence: true
  validates :status, inclusion: STATUSES

  def check_list!(dnc_list)
    if has_valid_input?
      #todo 
      list_file = dnc_list.search(input)
      update_list_status(list_file)
      #set_metadata(:source, list_file.upload_original_filename)
      save! 
      reload
    else
      update(status: ERROR) 
    end

    self
  end

  def invalid!
    self.status = ERROR
  end

  def ok!
    self.status = OK
  end

  def do_not_call!
    self.status = NOT_OK
  end
 
  def has_valid_input?
    ValidTextInput.new(self.input).valid?
  end

  def not_ok?
    self.status == NOT_OK
  end

  def result_status_text
    return "" unless self.status
    status.humanize.titleize 
  end

  protected

  def update_list_status(list_file)
    self.status = (list_file.nil? ? OK : NOT_OK)
  end
end
