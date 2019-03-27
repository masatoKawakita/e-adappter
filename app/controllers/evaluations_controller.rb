class EvaluationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversion = Conversion.find(params[:evaluation][:conversion_id])
    evaluator_id, evaluated_id = @conversion.setEvaluationParams(current_user)
    @evaluation = @conversion.evaluations.build(evaluator_id: evaluator_id,
                                                evaluated_id: evaluated_id,
                                                value: params[:value].to_i)
    if @evaluation.save
      respond_to do |format|
        flash[:success] = "評価が完了しました。"
        format.js {render :create}
      end
    else
      respond_to do |format|
        flash[:danger] = @evaluation.errors.full_messages
        format.js {render 'layouts/error'}
      end
    end
  end
end
