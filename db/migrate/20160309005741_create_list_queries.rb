class CreateListQueries < ActiveRecord::Migration
  def change
    create_table :list_queries do |t|
      t.string :input, null: false
      t.string :status, null: false

      t.timestamps null: false
    end
  end
end
