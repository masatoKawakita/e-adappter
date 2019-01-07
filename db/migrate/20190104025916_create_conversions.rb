class CreateConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversions do |t|
      t.integer :diveloper_id
      t.integer :advertiser_id
      t.integer :advertisement_id
      t.boolean :temporary_confirm, default: false, null: false
      t.boolean :definitive_confirm, default: false, null: false
      t.integer :fee
      t.timestamps
    end
    add_index :conversions, [:diveloper_id, :advertiser_id, :advertisement_id], unique: true, :name => :index_conversions_on_diveloper_advertiser_and_advertisement_id
  end
end
