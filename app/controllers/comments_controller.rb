class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find_by(id: params[:id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:notice] = 'コメントの投稿に成功しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    redirect_back(fallback_location: root_path) unless @comment.user_id == current_user.id
    @comment.destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
