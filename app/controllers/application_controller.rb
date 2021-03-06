class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_current_user

     def set_current_user
     Expenditure.current_user = current_user
     Report.current_user = current_user
     District.current_user = current_user
     end
     
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

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :notify_when_new_expenditure, :notify_when_new_report)}
         end


         def is_subscriber?
          redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
        end
end
