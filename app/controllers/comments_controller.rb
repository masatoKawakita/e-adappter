class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @advertisement = Advertisement.find(params[:advertisement_id])
    @comment = @advertisement.comments.build(set_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        flash[:success] = "コメントしました。"
        format.js {render :index}
      else
        flash[:danger] = "コメントを入力してください。"
        format.js {render 'layouts/error'}
      end
    end
  end

  private

  def set_params
    params.require(:comment).permit(:content)
  end
end
