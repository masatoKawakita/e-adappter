class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :validatable, :trackable, :omniauthable,
         omniauth_providers: %i(twitter)
  validates :name, presence: true
  validates :email, presence: true
  validates :twitter, format: /\A#{URI::regexp(%w(http https))}\z/, if: :twitter_url_exists?
  validates :facebook, format: /\A#{URI::regexp(%w(http https))}\z/, if: :facebook_url_exists?
  mount_uploader :icon, IconUploader
  has_many :advertisements, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_advertisements, through: :favorites, source: :advertisement
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  def twitter_url_exists?
    return false if twitter == "" || twitter == nil
    return true
  end

  def facebook_url_exists?
    return false if facebook == "" || twitter == nil
    return true
  end

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.search(keyword)
    return User.all unless keyword && keyword != ""

    words = keyword.to_s.gsub(/(?:[[:space:]%_])+/, " ").split(" ")
    columns = ["name", "content"]
    query = []
    results = []

    columns.each { |column| query.push(["#{column} like ?"]) }

    words.each_with_index do |w, index|
    case index
      when 0
        results[index] = User.where([query.join(" or "), "%#{w}%",  "%#{w}%"])
      else
        results[index] = results.last.where([query.join(" or "), "%#{w}%",  "%#{w}%"])
      end
    end
    return results.last
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider: auth.provider,
                      uid:      auth.uid,
                      email:    "#{auth.uid}-#{auth.provider}@example.com",
                      password: Devise.friendly_token[0, 20],
                      name:     auth.info.name,
                      content:  auth.info.description,
      )
    end
    user.save
    user
  end
end
