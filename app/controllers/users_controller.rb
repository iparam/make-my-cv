class UsersController < ApplicationController
  def profile
    @user = current_user
  end
  def update_profile
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to profile_path
    end
  end
end
