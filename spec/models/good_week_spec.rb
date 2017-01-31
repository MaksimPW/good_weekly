require 'rails_helper'

RSpec.describe GoodWeek, type: :model do
  it { should validate_presence_of(:monday) }
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:books) }
  it { should have_and_belong_to_many(:persons) }

  describe 'self.find_by_number_of_year_and_week' do
    let!(:user) { create(:user) }
    let!(:good_week) { create(:good_week, user: user) }

    it 'found if cweek and year valid' do
      expect(good_week).to eq user.good_weeks.find_by_number_of_year_and_week(good_week.year, good_week.number_of_year)
    end

    it 'not found if cweek and year other' do
      expect(good_week).to_not eq user.good_weeks.find_by_number_of_year_and_week(good_week.year+1, good_week.number_of_year)
    end
  end
end
