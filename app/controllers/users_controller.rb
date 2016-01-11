class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
<<<<<<< HEAD
    if current_user != @user
=======
    if current_user != current_user
>>>>>>> practice2
      redirect_to root_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
    
    if @user.update(user_params)
      redirect_to root_path , notice: '更新しました'
    else
      render 'edit'
    end
  end
  
  #フォローしている人
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users #@userがフォローしている人
  end
  
  #フォローしてくれた人
  def followers
    @user = User.find(params[:followed_id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :location, :profile)
  end

end



