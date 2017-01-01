class GoodWeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good_week, only: :show

  def current_week
    @good_week = GoodWeek.find_by(monday: DateTime.now.beginning_of_week.to_date)
    render :show
  end

  private
  def set_good_week
    @good_week = GoodWeek.find(params[:id])
  end

  def good_week_params
    params.fetch(:good_week, {})
  end
end
