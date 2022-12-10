class Api::V1::PostsController < ApplicationController
    before_action :authorize_request
    before_action :find_user
  
    def index
      user = User.find(params[:user_id])
      posts = user.posts.includes(:comments)
  
      if posts.size.positive?
        render json: posts, status: :ok
      else
        render json: { message: 'No posts found' }, status: :not_found
      end
    end
  
    def show
      @post = @user.posts.find_by_id!(params[:id])
      render json: @post, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Post not found' }, status: :not_found
    end

    def def create
      @user = User.find_by_id!(params[:user_id])
      @post = @user.posts.create!(post_params)
      render json: @post, status: :created
    end
  
    private
  
    def find_user
      @user = User.find_by_id!(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'User not found' }, status: :not_found
    end
    def post_params
      params.permit(:title, :text, :user_id)
    end
end
