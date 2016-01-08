class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #if current_user != current_user
    #  redirect_to root_path
    #end
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user = User.new(user_params)
      redirect_to root_path , notice: '更新しました'
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end



