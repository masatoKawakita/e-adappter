class RemoveIconFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :icon
  end
end
