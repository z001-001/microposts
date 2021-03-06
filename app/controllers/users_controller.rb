class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(".flash_welcome") #"Welcome to the Sample App!"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # 更新に成功した場合
      flash[:success] = t(".flash_update_success") #"Success. Update of User Settings"
      redirect_to @user
    else
      # 更新に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def followings
    @title = t(".title_followings") # "Followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'followings_followers'
  end

  def followers
    @title = t(".title_followers") # "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'followings_followers'
  end

  def favorites
    @user = User.find(params[:id])
    @microposts = @user.favorite_microposts.page(params[:page])
    render 'favorites'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :description, :location, :url)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
