# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

### ListFile
if ListFile.active.where(state: 'pa').blank?
  require 'import_list_file'
  list_file = ListFile.create!( state: 'pa', upload: File.new(File.join(Rails.root, 'spec', 'fixtures', 'dnc_sample.txt')), active: true)
  n = ImportListFile.new(model: list_file, logger: Rails.logger).perform
end

