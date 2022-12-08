class PostsController < ApplicationController
    load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    newpost = Post.new
    respond_to do |format|
      format.html { render :new, locals: { newpost: } }
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.likes_counter = 0
    @post.comments_counter = 0

    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post saved successfully'
          redirect_to user_post_path(current_user, @post.id)
        else
          newpost = Post.new
          flash.now[:error] = 'Error: post could not be saved'
          render :new, locals: { newpost: }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    @user.decrement!(:posts_counter)
    respond_to do |format|
      format.html do
        flash[:success] = 'Post deleted successfully'
        redirect_to user_posts_path
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
