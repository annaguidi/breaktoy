require 'rails_helper'
feature "User logs in" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario 'user navigates to log in page' do
    visit root_path
    expect(page).to have_content('Sign up')
  end
  scenario 'user successfully logs in' do
    login(user)

    expect(page).to have_content("Sign out")
    expect(page).to_not have_content("Sign in")
  end
  scenario 'user unsuccessfully logs in' do
    visit '/'
    click_link 'Sign in'

    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"

    click_on "Log in"

    expect(page).to have_content("Invalid email or password.")
  end
end
