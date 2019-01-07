# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## User setting
      t.string :name, null: false, default: ""
      t.string :icon, default: "user_default_icon.png"
      t.text :content
      t.string :twitter
      t.string :facebook

      t.string :provider, null: false, default: ""
      t.string :uid, null:false, default: ""

      t.boolean :want_to_advertise, default: false, null: false
      t.boolean :want_to_be_advertised, default: false, null: false
      t.boolean :admin, default: false, null: false

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:uid, :provider], unique: true
  end
end
