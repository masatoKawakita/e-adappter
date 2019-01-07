class AddActiveToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :active, :boolean, default: true, null: false
  end
end
