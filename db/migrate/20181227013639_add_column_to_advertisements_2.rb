class AddColumnToAdvertisements2 < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :request_follower, :string
    add_column :advertisements, :target_sex, :string
    add_column :advertisements, :target_age, :string
    add_column :advertisements, :app_category, :string
  end
end
