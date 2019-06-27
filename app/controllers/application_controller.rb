class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image_cache, :remove_image, :image])
    end
    
  private
  
    def counts(user)
      @count_posts = user.posts.count
      @count_followings = user.followings.count
      @count_followers = user.followers.count
      @count_likes = user.liked_posts.count
    end

    def set_search
      query = { title_or_content_or_book_or_direction_or_summary_cont: params[:q] }
      @q = Post.ransack(query)
      @posts = @q.result.page(params[:page])
      @like_counts = Favorite.group(:post_id).order('count_post_id DESC').count(:post_id).keys
      @like_count_posts_array = @like_counts.map{|id| Post.find(id)}
      @like_posts = Post.where(id: @like_count_posts_array.map{ |post| post.id }) # ActiveRecord::Relationに戻す
      @liking = @like_posts.ransack(query).result.page(params[:page]).per(15)
    end
end
