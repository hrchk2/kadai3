class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  
  def index
    @booknew =Book.new
    @user = current_user
    @users = User.all.order(id: :asc)
  end
  
  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
      if @user.update(user_params)
         redirect_to user_path(@user.id),notice:"You have updated user successfully."
      else
         render:edit
      end
  end
  
  def show
    @user = User.find(params[:id])
    @booknew=Book.new
    @books = @user.books
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email,:introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end

   def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
end
