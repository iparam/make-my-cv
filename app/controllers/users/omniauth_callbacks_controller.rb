class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!
  def linkedin
    #render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    omniauth = request.env["omniauth.auth"]
    @user = User.find_for_linkedin_oauth(omniauth,current_user)
    if @user.present? 
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Linkedin"
     if current_user 
        redirect_to profile_path
     else
      sign_in_and_redirect @user, :event => :authentication
     end 

    else
      #NEED MORE INFo
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    # request.env["omniauth.auth"].extra["access_token"].secret
    # request.env["omniauth.auth"].extra["access_token"].token
      # User.find_for_linkedin_oauth(access_token,params[:oauth_verifier],current_user)
    
  end
 
  def passthru
     render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
 
  
end