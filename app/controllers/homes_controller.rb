class HomesController < ApplicationController
  def index
    redirect_to advertisements_path if user_signed_in?
  end

  def use
  end

  def protect
  end
end
