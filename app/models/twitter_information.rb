class TwitterInformation < ApplicationRecord
  belongs_to :user
  has_many :twitter_categories, dependent: :destroy, inverse_of: :twitter_information
  accepts_nested_attributes_for :twitter_categories, reject_if: :all_blank, allow_destroy: true

  def self.setClient
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_ID_DEVELOPMENT"]
      config.consumer_secret     = ENV["TWITTER_SECRET_DEVELOPMENT"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
    client
  end

  def pluckColumns
    return twitter_categories.pluck(:label), twitter_categories.pluck(:data)
  end
end
