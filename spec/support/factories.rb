require_relative 'helpers'

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "12345678"
  end

  factory :profile do
    sequence(:name) { |n| "Angelica#{n}" }
    location "Boston"
    avatar_url "https://s-media-cache-ak0.pinimg.com/236x/50/bb/11/50bb1149e480e46d721d8a813a8ef3d4.jpg"
    about "Isn't this punny?!"
    user
  end

  factory :group do
    name "Tulipe"
  end

  factory :member do
    user
    group
  end
end
