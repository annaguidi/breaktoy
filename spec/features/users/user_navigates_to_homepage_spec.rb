require 'rails_helper'
feature "User logs out" do
  scenario 'user successfully logs out' do
    user = FactoryGirl.create(:user)
    profile = FactoryGirl.create(:profile, user: user)

    login(user)

    visit profile_path(profile)

    expect(page.current_path).to eq profile_path(profile)

    click_link "Home Page"

    expect(page.current_path).to eq staticpages_path
  end
end
