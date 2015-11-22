class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = t(".flash_success", name: @user.name) #"logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = t(".flash_failed") #"Invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
