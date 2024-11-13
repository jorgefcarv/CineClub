class CustomSessionsController < ApplicationController
    before_action :authenticate_user!
  
    def destroy
      sign_out(current_user) # Isso faz logout do usuário
      redirect_to root_path, notice: "Você saiu com sucesso."
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end
end