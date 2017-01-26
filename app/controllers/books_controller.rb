class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weeks, only: [:update, :create]
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
  def set_weeks
    return unless params[:good_week_ids].present?
    good_week_ids = Array.new
    week_mondays = params[:good_week_mondays].split.map { |m| m.to_date }
    unless week_mondays.empty?
      week_mondays.each do |monday|
        week = GoodWeek.find_by(monday: monday, user: current_user)
        if week
          good_week_ids << week.id
        else
          if monday.monday?
            week = GoodWeek.create(monday: monday, user: current_user)
            good_week_ids << week.id
          end
        end
      end
    end
    params[:book][:good_week_ids] = good_week_ids
  end

  def book_params
    params.require(:book).permit(:name, :description, :author, :comment, :rating, good_week_ids: [])
  end

  def load_book
    @book = Book.find(params[:id])
  end
end