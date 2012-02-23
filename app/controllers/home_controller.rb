class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
   redirect_to profile_url if current_user
    
    
  end
end
