class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weeks, only: [:update, :create]
  before_action :load_person, only: [:show, :edit, :update, :destroy]

  def index
    @persons = Person.where(user: current_user)
  end

  def show
    authorize @person
  end

  def new
    authorize @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user
    authorize @person
    if @person.save
      redirect_to people_path(@person)
    end
  end

  def edit
    authorize @person
  end

  def update
    authorize @person
    if @person.update_attributes(person_params)
      redirect_to people_path(@person)
    end
  end

  def destroy
    authorize @person
    if @person.delete
      redirect_to people_path
    end
  end

  private
  def set_weeks
    return unless params[:good_week_mondays].present?
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
    params[:person][:good_week_ids] = good_week_ids
  end

  def person_params
    params.require(:person).permit(:fio, :birthday, :description, :note, good_week_ids: [])
  end

  def load_person
    @person = Person.find(params[:id])
  end
end