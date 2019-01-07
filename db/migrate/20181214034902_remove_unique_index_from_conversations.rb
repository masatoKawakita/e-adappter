class RemoveUniqueIndexFromConversations < ActiveRecord::Migration[5.1]
  def change
    remove_index :conversations, :name => :index_conversations_on_sender_recipient_and_advertisement_id
  end
end
