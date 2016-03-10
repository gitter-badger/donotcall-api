class CreateListFiles < ActiveRecord::Migration
  def change
    create_table :list_files do |t|
      t.string :state, null: false, limit: 2, index: true
      t.string :upload_file_name, null: false
      t.integer :upload_file_size, default: 0
      t.string :upload_content_type, null: false
      t.datetime :upload_updated_at
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
