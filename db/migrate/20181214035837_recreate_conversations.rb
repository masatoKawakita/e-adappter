class RecreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.bigint :advertisement_id

      t.timestamps
    end

    add_index :conversations, [:sender_id, :recipient_id, :advertisement_id], unique: true, :name => :index_conversations_on_sender_recipient_and_advertisement_id
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
    add_index :conversations, :advertisement_id
  end
end
