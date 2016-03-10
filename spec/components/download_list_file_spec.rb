require 'rails_helper'
require 'download_list_file'

RSpec.describe DownloadListFile do

  let(:complete_result) { DownloadListFile.new(FactoryGirl.create(:list_file)).perform }

  context 'failure' do
    it 'fails when fingerprint missing' do
      list_file = FactoryGirl.create(:list_file)
      list_file.upload_fingerprint = nil
      expect { DownloadListFile.new(list_file) }.to raise_error(ArgumentError)
    end

    it 'fails when S3 download fails' do
      pending "to do: mock s3 storage environment"
    end

    it 'fails when downloaded file checksum does not match' do
      list_file = FactoryGirl.create(:list_file)
      list_file.upload_fingerprint = '12345'
      expect { DownloadListFile.new(list_file).perform }.to raise_error(RuntimeError)
    end
  end

  it 'returns a Tempfile with path set' do
    expect(complete_result).to be_instance_of(Tempfile)
    expect(complete_result.path).not_to be_empty
    expect(File.exist?(complete_result.path)).to eq(true)
  end
end
