class UsersController < ApplicationController
  def new
    if session[:user_id]
      redirect_to events_path
    else
      @user = User.new
    end
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
    @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], city: params[:city], state: params[:state])
    if @user.save
      flash[:notice] = ["Information updated."]
      redirect_to events_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  protected
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :confirm_pw, :city, :state)
    end

    def update_params
      params.permit(:first_name, :last_name, :email, :city, :state)
    end
end
