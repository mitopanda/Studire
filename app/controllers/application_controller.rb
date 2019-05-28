class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search # ransack
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception

  protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image_cache, :remove_image, :crop_x, :crop_y, :crop_w, :crop_h, :image])
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
    end
end
