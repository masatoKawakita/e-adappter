class RemoveIndexFromConversations < ActiveRecord::Migration[5.1]
  def change
    remove_index :advertisements, :name => :index_conversations_on_sender_id_and_recipient_id
  end
end
