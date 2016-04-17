require 'rails_helper'
feature "User updates profile" do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user navigates to edit profile page' do
    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit profile_path(profile)

    fill_in 'Name', with: "Anna"
    fill_in 'Current location', with: "Milan, Italy"
    fill_in 'About me', with: "About to move to Rotterdam, NL"

    click_on 'Update'

    expect(page).to have_content('Profile updated!')
  end
end
