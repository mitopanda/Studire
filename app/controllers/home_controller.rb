class HomeController < ApplicationController
  before_action :liking

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
      @liking = @like_posts.tagged_with(params[:tag]).page(params[:page]).per(15)
    elsif params[:q]
    else
      @posts = Post.all
      @liking = @like_posts.page(params[:page]).per(15)
    end
      @posts = @posts.order('created_at DESC').page(params[:page]).per(15)
      @tags_counts = Post.tag_counts_on(:tags).order('count DESC')
  end

  private
  def liking
      @liking_counts = Favorite.group(:post_id).order('count_post_id DESC').count(:post_id).keys
      @like_count_posts_array = @liking_counts.map{|id| Post.find(id)}
      @like_posts = Post.where(id: @like_count_posts_array.map{ |post| post.id }) # ActiveRecord::Relationに戻す
  end
end
