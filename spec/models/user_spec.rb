require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:good_weeks) }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let(:good_week) { create(:good_week, user: user) }

    it 'if current user is author of good_week' do
      expect(user).to be_author_of(good_week)
    end
  end
end
