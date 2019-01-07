class RemoveColumnFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :want_to_advertise, :booleran
    remove_column :users, :want_to_be_advertised, :booleran
  end
end
