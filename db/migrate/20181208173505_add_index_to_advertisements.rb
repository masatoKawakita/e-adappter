class AddIndexToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_index :advertisements, :user_id
  end
end
