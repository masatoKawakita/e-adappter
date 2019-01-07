class AddColumnToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :advertisement_id, :bigint
    add_index :conversations, :advertisement_id
    add_index :conversations, [:sender_id, :recipient_id, :advertisement_id], unique: true, :name => :index_conversations_on_sender_recipient_and_advertisement_id
  end
end
