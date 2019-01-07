class Conversion < ApplicationRecord
  belongs_to :diveloper, foreign_key: :diveloper_id, class_name: 'User'
  belongs_to :advertiser, foreign_key: :advertiser_id, class_name: 'User'
  belongs_to :advertisement

  validates_uniqueness_of :advertisement_id, scope: [:diveloper_id, :advertiser_id]

  scope :between, -> (diveloper_id, advertiser_id) do
    where("(conversions.diveloper_id = ? AND conversions.advertiser_id = ?) OR (conversions.diveloper_id = ? AND conversions.advertiser_id = ?)", diveloper_id, advertiser_id, advertiser_id, diveloper_id)
  end
end
