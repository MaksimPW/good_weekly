FactoryGirl.define do
  factory :good_week do
    monday Time.now.beginning_of_week
  end
end