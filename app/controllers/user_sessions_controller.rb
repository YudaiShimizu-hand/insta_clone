class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
  end
end