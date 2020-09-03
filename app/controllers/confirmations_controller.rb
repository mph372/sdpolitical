class ConfirmationsController < Devise::ConfirmationsController


    private

    def after_confirmation_path_for(resource_name, resource)
        sign_in(resource)
        if resource.subscribed?
        dashboard_index_path
        else
        '/pricing'
        end
    end
end