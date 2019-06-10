class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(10)
    @followings = @user.followings.page(params[:page]).per(10)
    @followers = @user.followers.page(params[:page]).per(10)
    @liking = @user.liked_posts.page(params[:page]).per(10)
    counts(@user)
  end
end
