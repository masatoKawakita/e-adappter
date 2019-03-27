class Conversion < ApplicationRecord
  belongs_to :diveloper, foreign_key: :diveloper_id, class_name: 'User'
  belongs_to :advertiser, foreign_key: :advertiser_id, class_name: 'User'
  belongs_to :advertisement
  belongs_to :conversation
  has_many :evaluations, foreign_key: 'conversion_id', class_name: 'Evaluation', dependent: :destroy
  validates_uniqueness_of :conversation_id, scope: [:diveloper_id, :advertiser_id]

  scope :between, -> (diveloper_id, advertiser_id) do
    where("(conversions.diveloper_id = ? AND conversions.advertiser_id = ?) OR (conversions.diveloper_id = ? AND conversions.advertiser_id = ?)", diveloper_id, advertiser_id, advertiser_id, diveloper_id)
  end

  def setEvaluationParams(current_user)
    evaluator_id = current_user.id
    evaluated_id = conversation.target_user(current_user).id
    return evaluator_id, evaluated_id
  end
end
