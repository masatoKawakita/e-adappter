class AddIndexToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end
end
