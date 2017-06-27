class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_out_path_for(resource)
    root_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :group, :profile, :works])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :group, :profile, :works])
  end
end
