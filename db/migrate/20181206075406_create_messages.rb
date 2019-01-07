class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.bigint :conversation_id
      t.bigint :user_id
      t.text :body
      t.boolean :read, default: false, null: false

      t.timestamps
    end

    add_index :messages, [:conversation_id, :user_id], unique: true
  end
end
