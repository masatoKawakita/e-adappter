class AddColumnToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :hash_01, :string
    add_column :advertisements, :hash_02, :string
    add_column :advertisements, :hash_03, :string
    add_column :advertisements, :hash_04, :string
    add_column :advertisements, :about_function, :text
    add_column :advertisements, :about_target, :text
    add_column :advertisements, :about_condition, :text
    add_column :advertisements, :about_fee, :text
  end
end
