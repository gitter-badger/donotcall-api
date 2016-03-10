require 'rails_helper'

RSpec.describe ListFile, type: :model do
  it 'has a vaild factory' do
    expect(FactoryGirl.build(:list_file).valid?).to eq(true)
  end

  describe '#active' do
    it 'returns only active records' do
      a = FactoryGirl.create(:list_file, active: true)
      b = FactoryGirl.create(:list_file, active: false)
      expect(ListFile.active.count).to eq(1)
      expect(ListFile.active.first).to eq(a)
    end
  end

  describe '#local_file' do
    it 'returns an existing filepath' do
      list_file = FactoryGirl.create(:list_file)
      puts File.exist?(list_file.upload.path)
      path = list_file.local_file
      expect(File.exist?(path)).to eq(true)
    end
  end
end
