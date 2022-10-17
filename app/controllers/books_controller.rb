class BooksController < ApplicationController
  def new
    @book=Book.new
  end

  def create
    @booknew=Book.new(book_params)
    @booknew.user_id = current_user.id
    @user = current_user
    if @booknew.save
       redirect_to book_path(@booknew.id),notice:"You have created book successfully."
    else
      @books =Book.all.order(id: :asc)
      render :index
    end
  end

  def index
    @booknew =Book.new
    @books =Book.all.order(id: :asc)
    @user = current_user
  end

  def show
   @book = Book.find(params[:id])
   @user =@book.user
   @booknew =Book.new
  end
   
  def edit
    edit_user
    @book = Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id),notice:"You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
  params.require(:book).permit(:title, :body)
  end

  
  def edit_user
    book = Book.find(params[:id])
    if book.user != current_user 
      redirect_to books_path
    end
  end

end
