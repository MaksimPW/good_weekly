class GoodWeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good_week, only: :show

  def index
    @good_weeks = GoodWeek.all
  end

  def show
  end

  private
  def set_good_week
    @good_week = GoodWeek.find(params[:id])
  end

  def good_week_params
    params.fetch(:good_week, {})
  end
end
