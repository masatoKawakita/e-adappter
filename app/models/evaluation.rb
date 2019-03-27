class Evaluation < ApplicationRecord
  belongs_to :evaluator, foreign_key: :evaluator_id, class_name: 'User'
  belongs_to :evaluated, foreign_key: :evaluated_id, class_name: 'User'
  belongs_to :conversion
  validates_uniqueness_of :conversion_id, scope: [:evaluator_id, :evaluated_id]

  def checkEvaluator(current_user)
    evaluator_id == current_user.id ? true : false
  end

  def checkEvaluated(current_user)
    evaluated_id == current_user.id ? true : false
  end
end
