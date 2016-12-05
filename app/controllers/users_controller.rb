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
      redirect_to root_path, notice: "Registered!"
    elsif @user.errors.any?
      redirect_to sign_up_path
      flash[:error] = @user.errors.full_messages.join(". ")
    end
  end

  def update
    @user = User.find(params[:id])

    if current_user.id == @user.id
      if @user.update(update_params)
        redirect_to @user, notice: "User updated!"
      else
        render 'show'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])

    unless @user == current_user
      @user.destroy
      redirect_to users_path, notice: "User deleted!"
    else
      flash[:error] = "You can't delete yourself!"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name)
  end

  def update_params
    params.require(:user).permit(:password, :encrypted_password)
  end
end
