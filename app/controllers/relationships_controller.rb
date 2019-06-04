class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:notice] = 'ユーザをフォローしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:notice] = 'ユーザのフォローを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
