require 'rails_helper'
require 'import_list_file'

RSpec.describe ImportListFile do
  describe '#perform' do
    it 'imports the list' do
      # dnc_sample.txt fixtures has 10,000 rows of data
      model = FactoryGirl.create(:list_file, active: true)
      expect(ImportListFile.new(model: model, logger: Rails.logger).perform).to eq(10000) 
    end
  end
end
