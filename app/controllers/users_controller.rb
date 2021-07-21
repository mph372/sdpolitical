class UsersController < ApplicationController
  before_action :is_admin?

    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
  
      if @user.destroy
          redirect_to action: :index, notice: "User deleted."
      end
    end

    private

    def is_admin?
      redirect_to '/pricing', notice: "You do not have access this page!" unless current_user.admin?
    end

    def admin_mode
      Admin.last.admin_mode == true 
    end

  end