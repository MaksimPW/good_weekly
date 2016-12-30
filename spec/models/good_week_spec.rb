require 'rails_helper'

RSpec.describe GoodWeek, type: :model do
  it { should validate_presence_of(:monday) }
end
