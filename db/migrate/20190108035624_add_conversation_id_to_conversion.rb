class AddConversationIdToConversion < ActiveRecord::Migration[5.1]
  def change
    add_column :conversions, :conversation_id, :integer
    add_index :conversions, :conversation_id, unique: true
  end
end
