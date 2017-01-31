class GoodWeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good_week, only: :show
  before_action :week_now, only: [:current_week, :show]

  def current_week
    @good_week = @week_now
    authorize @good_week
    render :show
  end

  def show
    redirect_to current_week_path if @week_now == @good_week
    authorize @good_week
  end

  def create
    @good_week = GoodWeek.new(good_week_params)
    @good_week.user = current_user
    if @good_week.save
      redirect_to week_path(@good_week.year, @good_week.number_of_year)
    end
  end

  def update
    @good_week = current_user.good_weeks.find_by(monday: params[:good_week][:monday]) || GoodWeek.find(params[:id])
    if @good_week.update_attributes(good_week_params)
      redirect_to week_path(@good_week.year, @good_week.number_of_year)
    end
  end

  private
  def week_now
    @week_now = GoodWeek.find_by(monday: DateTime.now.beginning_of_week.to_date)
    unless @week_now
      monday = DateTime.now.beginning_of_week
      @week_now = GoodWeek.new(monday: monday, user: current_user)
    end
  end

  def set_good_week
    @good_week = current_user.good_weeks.find_by_number_of_year_and_week(params[:year], params[:week]) if current_user
    unless @good_week
      monday = Date.commercial(params[:year].to_i, params[:week].to_i, 1)
      @good_week = GoodWeek.new(monday: monday, user: current_user)
    end
  end

  def good_week_params
    params.require(:good_week).permit(:monday, :note)
  end
end
