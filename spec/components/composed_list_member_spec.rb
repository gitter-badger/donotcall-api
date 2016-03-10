require 'rails_helper'
require 'composed_list_member'

RSpec.describe ComposedListMember do

  it 'assembles area_code and local part into object with phone number' do
    list_member = ComposedListMember.new('412', '8380940').compose
    expect(list_member.number).to eq('4128380940')
    expect(list_member.class).to eq(ListMember)
  end
end
