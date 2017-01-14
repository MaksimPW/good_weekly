require 'rails_helper'

describe GoodWeekPolicy do
  subject { GoodWeekPolicy.new(user, good_week) }

  context 'for a visitor' do
    let(:user) { nil }
    let(:good_week) { create(:good_week, user: create(:user)) }

    it { should_not permit(:current_week) }
    it { should_not permit(:show)    }
  end

  context 'for a user' do
    let(:user) { create(:user) }
    let(:good_week) { create(:good_week, user: user) }

    it { should permit(:current_week) }
    it { should permit(:show)    }
  end
end