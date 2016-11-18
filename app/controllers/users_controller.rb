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

  def edit
    @user = User.find(params[:id])
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
      if @user.update(user_params)
        redirect_to @user, :notice => "Signed up!"
      else
        flash.now[:error] = "Something went wrong"
        render 'show'
      end
    else
      flash.now[:error] = "Insufficient rights!"
      render 'show'
    end
  end

  def destroy
    @user = User.find(params[:id])

    unless @user == current_user
      @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:error] = "You can't delete yourself!"
    end
    redirect_to users_path

  end

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :user_name, :salt, :encrypted_password)
  end
end
