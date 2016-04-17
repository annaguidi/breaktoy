require 'rails_helper'
feature "User logs out" do
  scenario 'user successfully logs out' do
    user = FactoryGirl.create(:user)
    profile = FactoryGirl.create(:profile, user: user)

    login(user)

    expect(page).to have_content("Sign out")
    expect(page).to have_content("Signed in successfully")
    expect(page).to_not have_content("Sign in")

    click_on "Sign out"
    expect(page).to have_content("Sign in")
    expect(page).to_not have_content("Sign out")
  end
end
