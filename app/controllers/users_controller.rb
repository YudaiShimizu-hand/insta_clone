class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     auto_login(@user)
     redirect_to posts_path, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザー作成に失敗しました'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
