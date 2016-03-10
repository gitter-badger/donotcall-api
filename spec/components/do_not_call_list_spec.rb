require 'rails_helper'
require 'do_not_call_list'

RSpec.describe DoNotCallList do

  context '#search' do
    let(:numbers_on_list) { ['8149652682', '8149652685', '8149652687'] }
    let(:numbers_not_on_list) { ['7248380940', '4125551212'] }
    let(:active_list_file) { FactoryGirl.create(:list_file, status: active) }
   
    before do
      #active_list_file.import
    end
 
    it 'finds phone numbers on the list' do
            
    end

    it 'does not find a number not on the list' do

    end
  end
end
