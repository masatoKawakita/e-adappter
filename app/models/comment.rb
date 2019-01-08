class Comment < ApplicationRecord
  belongs_to :advertisement
  belongs_to :user
  validates :content, presence: true
end
