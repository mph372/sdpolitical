class RegistrationsController < Devise::RegistrationsController
    # prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.
    before_action :find_bot, only: :create

    protected

    #def after_sign_up_path_for(resource)
     #    '/pricing'
        # '/dashboard'
   # end

    private

    def find_bot
        return unless params[:hp] == '1'
        head :ok
    end
end