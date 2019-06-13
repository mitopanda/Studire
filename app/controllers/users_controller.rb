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

  def likes
    @likes = current_user.liked_posts
    if params[:q]
      query = { title_or_content_or_book_or_direction_or_summary_cont: params[:q] }
      @search = @likes.ransack(query)
      @liking = @search.result.order('created_at DESC').page(params[:page]).per(10)
    elsif params[:tag]
      @liking = @likes.tagged_with(params[:tag]).order('created_at DESC').page(params[:page]).per(15)
    else
      @liking = @likes.order('created_at DESC').page(params[:page]).per(10)
    end
  end
end
