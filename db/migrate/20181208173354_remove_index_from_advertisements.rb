class RemoveIndexFromAdvertisements < ActiveRecord::Migration[5.1]
  def change
    remove_index :advertisements, :name => :index_advertisements_on_user_id
  end
end
