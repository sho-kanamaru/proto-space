class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def show
    @prototypes = @user.prototypes.page(params[:page]).like
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "edited your account in successfully."
    else
      flash.now[:alert] = "cannot updated your account"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :email, :group, :profile, :works)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
