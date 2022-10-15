class BooksController < ApplicationController
  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book =Book.new
    @books =Book.all.order(id: :asc)
    @user = current_user
  end

  def show
   @book = Book.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private

  def book_params
  params.require(:book).permit(:title, :body)
  end

end