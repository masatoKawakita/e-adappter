class AddIndexToMessages < ActiveRecord::Migration[5.1]
  def change
    add_index :messages, :conversation_id
    add_index :messages, :user_id
  end
end
