class UsersController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    
    def create
        super
    end
  
    private
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthday, :username, :email])
    end
  end
  