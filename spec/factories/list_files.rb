FactoryGirl.define do
  factory :list_file do
    state "pa"
    upload File.new(File.join(Rails.root, 'spec', 'fixtures', 'dnc_sample.txt'))
    active false
  end
end
