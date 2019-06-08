class HomeController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
      @liking_counts = Favorite.group(:post_id).order('count_post_id DESC').count(:post_id).keys
      @like_count_post_array = @liking_counts.map{|id| Post.find(id)}
      @like_posts = Post.where(id: @like_count_post_array.map{ |post| post.id }) # ActiveRecord::Relationに戻す
      @liking = @like_posts.tagged_with(params[:tag]).page(params[:page]).per(15)
    # ransack用
    elsif params[:q]
    else
      @posts = Post.all
      @liking_counts = Favorite.group(:post_id).order('count_post_id DESC').count(:post_id).keys
      @like_count_post_array = @liking_counts.map{|id| Post.find(id)}
      @liking = Kaminari.paginate_array(@like_count_post_array).page(params[:page]).per(15)
    end
      @posts = @posts.order('created_at DESC').page(params[:page]).per(15)

      @tags = Post.tag_counts_on(:tags).order('count DESC')
  end
end
