class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new; end

  def show
    @user_id = params[:id]
    @user = User.includes(posts: %i[author]).find(params[:id].to_i)
  end
end
