class CreateTwitterCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_categories do |t|
      t.string  :label, null: false
      t.integer  :data, null: false
      t.integer :twitter_information_id, default: 0, null: false
      t.timestamps
    end

    add_index :twitter_categories, :twitter_information_id
  end
end
