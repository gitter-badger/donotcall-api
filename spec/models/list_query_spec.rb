require 'rails_helper'
require 'do_not_call_list'

RSpec.describe ListQuery, type: :model do
  let(:valid_input) { '7248380940' }
  let(:invalid_input) { '123word' }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:list_query).valid?).to eq(true)
  end

  describe '#has_valid_input?' do
    it 'not valid when using invalid input' do
      expect(FactoryGirl.build(:list_query, input: invalid_input).has_valid_input?).to eq(false) 
    end
  
    it 'valid when using valid input' do
      expect(FactoryGirl.build(:list_query, input: valid_input).has_valid_input?).to eq(true)
    end
  end
 
  describe '#check_list!' do
    it 'checks the DoNotCallList' do
      model = FactoryGirl.build(:list_query, input: valid_input)
      list = DoNotCallList.new
      expect(list).to receive(:search).with(valid_input)
      model.check_list!(list)
    end

    it 'status is set to do not call when a number is on the Do Not Call List' do
      model = FactoryGirl.build(:list_query, input: valid_input )
      list = double("list", :search => FactoryGirl.build(:list_file, active: true))
      model.check_list!(list)
      expect(model.status).to eq(ListQuery::NOT_OK)
    end

    it 'status is set to not on list when valid number is not on Do Not Call List' do
      model = FactoryGirl.build(:list_query, input: valid_input )
      list = double("list", :search => nil )
      model.check_list!(list)
      expect(model.status).to eq(ListQuery::OK)
    end
 
    context 'when model input field is not valid text' do
      it 'does not check the DNC List' do
        model = FactoryGirl.build(:list_query, input: invalid_input )
        list = double("list", search: nil)
        expect(list).not_to receive(:search).with(invalid_input)
        model.check_list!(list)
      end

      it 'will have error status' do
        model = FactoryGirl.build(:list_query, input: invalid_input)
        list = double("list", search: nil)
        model.check_list!(list)
        expect(model.status).to eq(ListQuery::ERROR) 
      end
    end
  end
 
  describe '#invalid!' do
    it 'sets status to Error' do 
      model = FactoryGirl.build(:list_query, status: nil)
      model.invalid!
      expect(model.status).to eq(ListQuery::ERROR) 
    end
  end

  describe '#do_not_call!' do
    it 'sets status to not ok' do 
      model = FactoryGirl.build(:list_query, status: nil)
      model.do_not_call!
      expect(model.status).to eq(ListQuery::NOT_OK) 
    end
  end

  describe '#ok!' do
    it 'sets status to OK' do 
      model = FactoryGirl.build(:list_query, status: nil)
      model.ok!
      expect(model.status).to eq(ListQuery::OK) 
    end
  end

  describe '#not_ok?' do
    it 'is true if status is not ok' do
      model = FactoryGirl.build(:list_query, status: ListQuery::NOT_OK)
      expect(model.not_ok?).to eq(true)
      model.status = ListQuery::ERROR
      expect(model.not_ok?).to eq(false)
    end
  end

  describe '#result_status_text' do
    it 'returns human-readable status text' do
      model = FactoryGirl.build(:list_query, status: ListQuery::OK)
      expect(model.result_status_text).to eq('Not Found On List')
    end
  end
end
