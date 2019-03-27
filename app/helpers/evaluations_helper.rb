module EvaluationsHelper
  def setHTML(evaluations)
    target = nil
    if evaluations.present?
      evaluations.each do |evaluation|
        target = evaluation if evaluation.checkEvaluator(current_user)
      end
    end
    target == nil ? true : false
  end

  def setValue(evaluations)
    target = nil
    evaluations.each do |evaluation|
      target = evaluation if evaluation.checkEvaluated(current_user)
    end
    target == nil ? 'まだ相手が評価しておりません' : target.value
  end
end
