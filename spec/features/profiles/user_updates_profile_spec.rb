require 'rails_helper'
feature "User updates profile" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario 'user navigates to edit profile page' do

    login(user)
    click_link "Profile"

    visit profile_path(profile)

    click_link "Edit Profile"

    fill_in 'Name', with: "Anna"
    fill_in 'Current location', with: "Milan, Italy"
    fill_in 'About me', with: "About to move to Rotterdam, NL"

    click_on 'Update'

    expect(page).to have_content('Profile updated!')

    visit profile_path(profile)

    expect(page).to have_content("Anna")
    expect(page).to have_content("Milan, Italy")
    expect(page).to have_content("About to move to Rotterdam, NL")
  end
end
