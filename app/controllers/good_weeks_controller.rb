class GoodWeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good_week, only: :show
  before_action :week_now, only: [:current_week, :show]

  def current_week
    authorize @week_now
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
    @good_week = GoodWeek.find(params[:id])
  end

  def good_week_params
    params.fetch(:good_week, {})
  end
end
