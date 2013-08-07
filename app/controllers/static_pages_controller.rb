class StaticPagesController < ApplicationController
  def home
    # defining @micropost instance variable for usage for home page
    @micropost = current_user.microposts.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end

end