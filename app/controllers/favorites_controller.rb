class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:notice] = 'いいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:notice] = 'いいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
