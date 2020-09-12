class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  acts_as_token_authentication_handler_for User
  before_action :configure_permitted_parameters, if: :devise_controller?
    
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image_url])
  end
  
  #The token authentication requirement can target specific controller actions:
  acts_as_token_authentication_handler_for User, only: [:create, ]

end
