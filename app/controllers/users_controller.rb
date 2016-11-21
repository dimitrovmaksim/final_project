class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  skip_before_action :check_admin, only: [:show, :new, :create, :update]

  def index
    @users = User.order('LOWER(user_name)')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if current_user.id == @user.id
      if current_user.admin?
        @user.update(user_params)
        redirect_to @user, :notice => "User updated!"
      else
        if @user.update(update_params)
          redirect_to @user, :notice => "User updated!"
        else
          render 'show'
        end
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])

    unless @user == current_user
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_path
    else
      flash[:error] = "You can't delete yourself!"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :user_name, :salt, :encrypted_password)
  end

  def update_params
    params.require(:user).permit(:password, :password_confirmation, :salt, :encrypted_password)
  end
end
