class CreateTwitterInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_informations do |t|
      t.integer :user_id,             default: 0, null: false
      t.integer :followers_count,     default: 0, null: false
      t.integer :followeds_count,     default: 0, null: false
      t.integer :favorites_count,     default: 0, null: false
      t.integer :tweets_count,        default: 0, null: false
      t.integer :liked_count,         default: 0, null: false
      t.integer :retweeted_count,     default: 0, null: false
      t.datetime :account_created_at            , null: false
      t.timestamps
    end

    add_index :twitter_informations, :user_id
  end
end
