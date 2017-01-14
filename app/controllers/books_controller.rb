class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.where(user: current_user)
  end

  def show
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
    authorize @book
  end

  def update
    authorize @book
    if @book.update_attributes(book_params)
      redirect_to book_path(@book)
    end
  end

  def destroy
    authorize @book
    if @book.delete
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:name, :description, :author, :comment, :rating)
  end

  def load_book
    @book = Book.find(params[:id])
  end
end