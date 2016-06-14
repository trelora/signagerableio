FactoryGirl.define do
  factory :user do
    email "admin@email.com"
    password "password"
  end
  factory :device do
    sequence(:device_code) { |n| "aaa#{n}" }
  end
end
