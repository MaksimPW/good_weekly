class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.where(user: current_user)
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
  end

  def new
    authorize @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    authorize @book
    if @book.save
      redirect_to book_path(@book)
    end
  end

  def edit
    @book = Book.find(params[:id])
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book
    if @book.update_attributes(book_params)
      redirect_to book_path(@book)
    end
  end

  def destroy
    @book = Book.find(params[:id])
    authorize @book
    if @book.delete
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:name, :description, :author, :comment, :rating)
  end
end