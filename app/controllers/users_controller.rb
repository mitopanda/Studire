class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end
end
