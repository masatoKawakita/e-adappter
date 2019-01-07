class AddWantToAdvertiseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :want_to_advertise, :boolean, default: true, null: false
    add_column :users, :want_to_be_advertised, :boolean, default: true, null: false
  end
end
