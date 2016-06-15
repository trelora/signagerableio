FactoryGirl.define do
  factory :device do
    sequence(:device_code) { |n| "aaa#{n}" }
  end
end
