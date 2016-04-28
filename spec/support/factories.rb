require_relative 'helpers'

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    name "Caterina"
    password "12345678"
  end

  factory :profile do
    sequence (:location) { |n| "Boston#{n}" }
    avatar_url "https://s-media-cache-ak0.pinimg.com/236x/50/bb/11/50bb1149e480e46d721d8a813a8ef3d4.jpg"
    about "Isn't this punny?!"
    user
  end

  factory :group do
    sequence(:name) { |n| "Tulipe#{n}" }
    city "Milano"
    country "Italy"
  end

  factory :member do
    user
    group
  end
end
