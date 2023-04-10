class PasswordResetsController < ApplicationController
  layout 'login'
  before_action :find_and_authenticate_user, only: [:edit, :update]

  def new
  end

  def create
    employee = Employee.find_by(email: params[:email].downcase)
    @user = employee.user if employee.present?
    if @user
      raw_token = @user.create_password_reset_token
      UserMailer.password_reset(@user, raw_token).deliver_now
      flash[:info] = "Password reset email sent. Please check your email."
      redirect_to root_url
    else
      flash[:danger] = "Email address not found."
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      flash[:danger] = "Password can't be empty."
      render :edit
    elsif @user.update(user_params)
      @user.clear_password_reset_token
      # Remove this line: log_in @user
      flash[:success] = "Password has been reset. Please log in with your new password."
      redirect_to root_url
    else
      flash[:danger] = "Password and confirmation don't match."
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_and_authenticate_user
    hashed_token = Digest::SHA256.hexdigest(params[:id])
    @user = User.find_by(password_reset_token: hashed_token)

    unless @user
      redirect_to root_url
    end
  end
end