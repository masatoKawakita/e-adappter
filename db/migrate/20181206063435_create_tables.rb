class CreateTables < ActiveRecord::Migration[5.1]
  def change
    ## User --------------------
    create_table :users do |t|
      t.string     :name,                  null: false, default: ""
      t.string     :provider,              null: false, default: ""
      t.string     :uid,                   null: false, default: ""
      t.string     :email,                 null: false, default: ""
      t.string     :encrypted_password,    null: false, default: ""
      t.string     :icon
      t.string     :twitter
      t.string     :facebook
      t.string     :reset_password_token
      t.text       :content
      t.integer    :sign_in_count,         null: false, default: 0
      t.boolean    :want_to_advertise,     null: false, default: true
      t.boolean    :want_to_be_advertised, null: false, default: true
      t.boolean    :admin,                 null: false, default: false
      t.inet       :current_sign_in_ip
      t.inet       :last_sign_in_ip
      t.datetime   :reset_password_sent_at
      t.datetime   :current_sign_in_at
      t.datetime   :last_sign_in_at
      t.timestamps                         null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:uid, :provider],     unique: true

    ## Advertisement --------------------
    create_table :advertisements do |t|
      t.string  :title,             null: false
      t.string  :app_url,           null: false
      t.string  :image
      t.string  :hash_01
      t.string  :hash_02
      t.string  :hash_03
      t.string  :hash_04
      t.string  :request_follower
      t.string  :target_sex
      t.string  :target_age
      t.string  :app_category
      t.text    :content,           null: false
      t.text    :about_function
      t.text    :about_target
      t.text    :about_condition
      t.text    :about_fee,         null: false
      t.bigint  :user_id
      t.boolean :active,            null: false, default: true
      t.timestamps
    end

    add_index :advertisements, :user_id

    ## Favorite --------------------
    create_table :favorites do |t|
      t.bigint :user_id
      t.bigint :advertisement_id
      t.timestamps
    end

    add_index :favorites, [:user_id, :advertisement_id], unique: true

    ## Relationship --------------------
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true

    ## Comment --------------------
    create_table :comments do |t|
      t.text    :content
      t.bigint  :advertisement_id
      t.integer :user_id
      t.timestamps
    end

    add_index :comments, :advertisement_id
    add_index :comments, :user_id

    ## Conversation --------------------
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.bigint  :advertisement_id
      t.timestamps
    end

    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
    add_index :conversations, :advertisement_id
    add_index :conversations, [:sender_id, :recipient_id, :advertisement_id],
                              unique: true,
                              :name => :index_conversations_on_sender_recipient_and_advertisement_id

    ## Message --------------------
    create_table :messages do |t|
      t.text    :body
      t.bigint  :conversation_id
      t.bigint  :user_id
      t.boolean :read, null: false, default: false
      t.timestamps
    end

    add_index :messages, :conversation_id
    add_index :messages, :user_id

    ## Conversion --------------------
    create_table :conversions do |t|
      t.integer :diveloper_id
      t.integer :advertiser_id
      t.integer :conversation_id
      t.integer :advertisement_id
      t.boolean :temporary_confirm,  null: false, default: false
      t.boolean :definitive_confirm, null: false, default: false
      t.integer :fee
      t.timestamps
    end

    add_index :conversions, :conversation_id, unique: true
    add_index :conversions, [:diveloper_id, :advertiser_id, :conversation_id],
                            unique: true,
                            :name => :index_conversions_on_diveloper_advertiser_and_conversation_id
  end
end
