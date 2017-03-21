class CommentsController < ApplicationController
  def create
    @comment = Comment.new(content: params[:comment], user_id: session[:user_id], event_id: params[:id])
    if @comment.save
      redirect_to :back
    else
      flash[:notice] = @comment.errors.full_messages
      redirect_to :back
    end
  end
end
