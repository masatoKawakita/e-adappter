class AddIndexToAdvertisemintId < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, :advertisement_id
  end
end
