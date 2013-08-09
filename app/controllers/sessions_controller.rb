class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    # debugger
    user = User.find_by_username(params[:user][:username])


    p params
    if user && user.validate_password(params[:user][:password])
      log_in(user)
      redirect_to cats_path
    else
      flash.now[:error] = "Invalid login. Please try again."
      render :new
    end
  end

  def destroy
    session[:token] = nil
    redirect_to cats_path
  end
end


