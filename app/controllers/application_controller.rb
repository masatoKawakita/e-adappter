class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :add_devise_permitted_params, if: :devise_controller?

  def add_devise_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :icon, :content, :twitter, :facebook, :want_to_advertise, :want_to_be_advertised, :uid])
  end
end
