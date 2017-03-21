class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = ["You have been registered! Please log in."]
      redirect_to root_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to root_path
    end
  end

  def edit
    if !current_user
      redirect_to root_path
    end
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(update_params)
    if @user.save
      flash[:notice] = ["Information updated."]
      redirect_to events_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to "users/#{session[:user_id]}"
    end
  end

  protected
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :confirm_pw, :city, :state)
    end

    def update_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state)
    end
end
