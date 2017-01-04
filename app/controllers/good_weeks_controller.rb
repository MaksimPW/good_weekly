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

  private
  def week_now
    @week_now = GoodWeek.find_by(monday: DateTime.now.beginning_of_week.to_date)
  end

  def set_good_week
    @good_week = current_user.good_weeks.find_by_number_of_year_and_week(params[:year], params[:week]) if current_user
  end

  def good_week_params
    params.fetch(:good_week, {})
  end
end
