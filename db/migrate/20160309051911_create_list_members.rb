class CreateListMembers < ActiveRecord::Migration
  def change
    create_table :list_members do |t|
      t.references :list_file, index: true, foreign_key: true
      t.string :number, null: false, index: true

      t.timestamps null: false
    end
  end
end
