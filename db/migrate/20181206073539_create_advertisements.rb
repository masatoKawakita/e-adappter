class CreateAdvertisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :image
      t.text :content
      t.string :app_url
      t.bigint :user_id

      t.timestamps
    end

    add_index :advertisements, :user_id, unique: true
  end
end
