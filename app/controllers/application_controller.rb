class ApplicationController < ActionController::Base
    layout :layout_by_resource
  
    private
  
    def layout_by_resource
      if devise_controller? && !user_signed_in?
        'layout_for_guest'
      else
        'application'
      end
    end
  end  