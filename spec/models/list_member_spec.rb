require 'rails_helper'

RSpec.describe ListMember, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:list_member).valid?).to eq(true)
  end

  
end
