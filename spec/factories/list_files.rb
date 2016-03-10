FactoryGirl.define do
  factory :list_file do
    state "pa"
    upload File.new(File.join(Rails.root, 'spec', 'fixtures', 'dnc_sample.txt'))
=begin
    upload_file_name File.join(Rails.root, 'spec', 'fixtures', 'dnc_sample.txt')
    upload_file_size 120000 
    upload_content_type "text/plain"
    upload_updated_at "2016-03-08 21:32:47"
=end
    active false
  end
end
