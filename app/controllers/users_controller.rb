class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) #extremely dangerous - throws error when working with Rails 4.0
    if @user.save
      #successful save
    else
      render 'new'
    end
  end

  private
  # new way to permit only listed attributes for user params
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
