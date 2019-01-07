class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.bigint :user_id
      t.bigint :advertisement_id

      t.timestamps
    end

    add_index :favorites, [:user_id, :advertisement_id], unique: true
  end
end
