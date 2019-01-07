class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.all
  end

  def create
    if Conversation.where(sender_id: params[:sender_id], recipient_id: params[:recipient_id], advertisement_id: params[:advertisement_id]).present?
      conversations = Conversation.between(params[:sender_id], params[:recipient_id])
      @conversation = conversations.find_by(advertisement_id: params[:advertisement_id])
    else
      @conversation = Conversation.create!(set_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def set_params
    params.permit(:sender_id, :recipient_id, :advertisement_id)
  end
end
