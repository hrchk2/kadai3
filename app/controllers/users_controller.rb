class UsersController < ApplicationController
  
  def index
    @booknew =Book.new
    @user = current_user
    @users = User.all.order(id: :asc)
  end
  
  def edit
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


end
