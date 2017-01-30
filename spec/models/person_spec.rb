require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should belong_to(:user)}
  it { should have_and_belong_to_many(:good_weeks) }
  it { should validate_presence_of(:fio) }
end
