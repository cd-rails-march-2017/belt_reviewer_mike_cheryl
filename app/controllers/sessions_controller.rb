class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to events_path
    else
      if !@user
        flash[:notice] = ["User not found. Please enter a valid email."]
      else
        flash[:notice] = ["Incorrect password."]
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
