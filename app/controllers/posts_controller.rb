class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
    @comment = current_user.comments.build
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to @post
    else
      flash.now[:alert]
      render :new
    end
  end

  def edit
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '投稿の編集に成功しました。'
      redirect_to root_url
    else
      flash.now[:alert] = "投稿の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'メッセージを削除しました。'
    redirect_to root_url
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :book, :direction, :summary, :tag_list)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
