class CommentsController < ApplicationController
  def index; end

  def new
    newcomment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { newcomment: } }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(post_id: @post.id, author_id: current_user.id, text: comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(current_user, @post.id)
    else
      newcomment = Comment.new
      flash.now[:error] = 'Error: comment could not be saved'
      render :new, locals: { newcomment: }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.where(id: @comment.post_id).first
    @comment.destroy
    @post.decrement!(:comments_counter)
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted successfully'
        redirect_to user_post_path(current_user, @post.id)
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
