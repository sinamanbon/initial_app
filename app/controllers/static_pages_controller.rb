class StaticPagesController < ApplicationController
  def home
    if signed_in?
    # defining @micropost instance variable for usage for home page
      @micropost = current_user.microposts.build if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end