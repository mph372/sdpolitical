class ConfirmationsController < Devise::ConfirmationsController


    private

    def after_confirmation_path_for(resource_name, resource)
        sign_in(resource)
        redirect_to '/pricing'
    end
end