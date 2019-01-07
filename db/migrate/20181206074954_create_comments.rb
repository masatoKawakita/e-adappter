class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.bigint :advertisement_id
      t.text :content

      t.timestamps
    end

    add_index :comments, :advertisement_id, unique: true
  end
end
