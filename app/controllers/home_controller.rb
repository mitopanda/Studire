class HomeController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    # ransack用
    #elsif params[:q]
    #  @q = Post.ransack(params[:q])
    #  @posts = @q.result.page(params[:page])
    else
      @posts = Post.all
    end
      @posts = @posts.order('created_at DESC').page(params[:page])
  end
end
