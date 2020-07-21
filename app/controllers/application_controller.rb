class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from ActionController::InvalidAuthenticityToken, :with => :bad_token
     def bad_token
     flash[:warning] = "Session expired"
     redirect_to root_path
     end

     def authorize_admin
          redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
     end

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password)}
         end

end
