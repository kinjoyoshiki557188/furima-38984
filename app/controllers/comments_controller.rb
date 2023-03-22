class CommentsController < ApplicationController

  def index
    @coment = Comment.order(id: "DESC")

  end
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast "comment_channel", {comment: @comment, user: @comment.user} #追加

    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
