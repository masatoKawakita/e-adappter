class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if user_signed_in?
      @user = User.find(params[:relationship][:followed_id])

      if params[:relationship][:pageowner_id].present?
        @pageowner = User.find(params[:relationship][:pageowner_id])
      else
        @pageowner = current_user
      end

      current_user.follow!(@user)
      @user
    else
      @user
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed

    if params[:relationship][:pageowner_id].present?
      @pageowner = User.find(params[:relationship][:pageowner_id])
    else
      @pageowner = current_user
    end

    current_user.unfollow!(@user)
    @user
  end
end
