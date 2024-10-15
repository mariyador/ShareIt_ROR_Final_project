class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successfully registered."
      redirect_to root_path
    else
      puts @user.errors.full_messages
      render :new
    end
  end

  def edit
    # The @user is already set by the before_action
  end

  def update
    puts user_params.inspect
    if @user.update(user_params)
      flash[:notice] = "User updated successfully."
      redirect_to @user
    else
      puts @user.errors.full_messages
      flash.now[:alert] = "Error updating user."
      render :edit
    end
  end

  def destroy
    if @user
      @user.destroy
      flash[:notice] = "Account deleted successfully."
      redirect_to root_path
    else
      flash[:alert] = "User not found."
      head :not_found # Return a 404 status
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "User not found."
      head :not_found # Return a 404 status instead of redirecting
      nil
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
