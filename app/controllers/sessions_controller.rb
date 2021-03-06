class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      flash[:success] = "#{ user.username } is successfully logged in"
      redirect_to root_path
    else
      flash[:failure] = "Username doesn't exist, try login again"
      render :new, status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout Successful"
    redirect_to root_path
  end

end
