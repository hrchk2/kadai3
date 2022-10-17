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
     @user.update(user_params)
     redirect_to user_path(@user.id)
  end
  
  def show
    @user = User.find(params[:id])
    @booknew=Book.new
    @books = @user.books
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email)
  end


end
