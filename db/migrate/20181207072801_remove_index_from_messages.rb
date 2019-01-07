class RemoveIndexFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_index :messsages, :name => :index_messages_on_conversation_id_and_user_id
  end
end
