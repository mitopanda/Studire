class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
end