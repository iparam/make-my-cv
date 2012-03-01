class UsersController < ApplicationController
  def profile
    @user = current_user
    @education = @user.educations.new
    @user.educations.build
  end
  def update_profile
    @user = current_user
    binding.pry
    if @user.update_attributes(params[:user])
      redirect_to profile_path
    end
  end
end
