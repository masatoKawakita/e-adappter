class Advertisement < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_one :conversion, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :conversations, dependent: :destroy
  validates :title, presence: true
  validates :app_url, presence: true
  validates :content, length: { in: 1..200 }, presence: true
  validates :about_fee, presence: true

  def favorite?(advertisement, user)
    advertisement.favorites.find_by(user_id: user.id)
  end

  def self.search(keyword)
    if keyword && keyword != ""
      words = keyword.to_s.gsub(/(?:[[:space:]%_])+/, " ").split(" ")
      columns = ["title", "content", "hash_01", "hash_02", "hash_03", "hash_04"]
      query = []
      result = []

      columns.each do |column|
        query << ["#{column} like ?"]
      end

      words.each_with_index do |w, index|
        if index == 0
          result[index] = Advertisement.where(query.join(" or "), "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%")
        else
          result[index] = result[index-1].where(query.join(" or "), "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%", "%#{w}%")
        end
      end
      return result[words.length-1]
    else
      Advertisement.all
    end
  end

  def self.category_search(categories)
    Advertisement.where(app_category: categories)
  end

  def self.target_sex_search(sex)
    Advertisement.where(target_sex: sex)
  end

  def self.target_age_search(age)
    Advertisement.where(target_age: age)
  end

  def self.request_follower_search(request)
    Advertisement.where(request_follower: request)
  end

  def self.active_search(boolean)
    Advertisement.where(active: boolean)
  end
end
