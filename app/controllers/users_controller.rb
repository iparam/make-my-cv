class UsersController < ApplicationController
 acts_as_flying_saucer
  def profile
    @user = current_user
    @user.user_info || @user.build_user_info
  end
  def update_profile
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to profile_path
    else
      render :action=>"profile"  
    end
  end
  def template1
    @user = current_user
    @user_experiences= @user.experiences.order_by([:start_date,:desc])
    @projects= @user.projects.order_by([[:start_date,:desc],[:end_date,:desc]])
    respond_to do |format|
      format.html
      format.pdf {render_pdf :template => 'users/template1',:send_file=>{:file_name=>"ss.pdf"}}
    end
  end
end
