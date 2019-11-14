class UsersController < ApplicationController
  before_action :set_profiles, only: [:show, :edit, :update]
  before_action :profile_edit_permission, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        render :edit
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end
  else
    redirect_to feeds_path
  end
end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :introduce, :age, :sex)
  end

  def set_profiles
    @user = User.find(params[:id])
  end

  def profile_edit_permission
    if @user.id != current_user.id
      redirect_to user_path(@user.id)
    end
  end
end
