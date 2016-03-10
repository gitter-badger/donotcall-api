class AddFingerprintToListFile < ActiveRecord::Migration
  def change
    add_column :list_files, :upload_fingerprint, :string
  end
end
