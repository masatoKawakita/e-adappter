class RemoveIndexFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_index :comments, :advertisement_id
  end
end
