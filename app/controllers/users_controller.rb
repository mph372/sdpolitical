class UsersController < ApplicationController

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

  end