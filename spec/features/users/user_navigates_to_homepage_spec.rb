require 'rails_helper'
feature "User navigates to home page" do
  scenario 'user successfully navigates to homepage' do
    user = FactoryGirl.create(:user)
    profile = FactoryGirl.create(:profile, user: user)

    login(user)

    visit profile_path(profile)

    expect(page.current_path).to eq profile_path(profile)

    click_link('love')

    expect(page.current_path).to eq root_path
  end
end
