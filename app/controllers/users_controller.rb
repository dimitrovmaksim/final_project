class UsersController < ApplicationController
  skip_before_action :authorize
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

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :user_name, :salt, :encrypted_password)
  end
end