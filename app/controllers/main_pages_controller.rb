class MainPagesController < ApplicationController
  def home
    @user = current_user || User.new
    @micropost = current_user.microposts.build if logged_in?
  end

  def contact
  end
end
