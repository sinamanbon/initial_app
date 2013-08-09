class MicropostsController < ApplicationController
  before_action :signed_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: [:destroy]

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      #passing empty array if can't create new micropost
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

  def micropost_params
    #strong parameters to only permit content to be edited
    params.require(:micropost).permit(:content)
  end

  def correct_user
    #using find_by instead of find
    #because find throws an exception when no micropost exists instead of returning nil
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  #using rescue for exceptions - find instead of find_by
  #def correct_user
  #  @micropost = current_user.microposts.find(params[:id])
  #rescue
  #  redirect_to root_url
  #end

end
