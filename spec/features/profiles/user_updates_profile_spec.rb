require 'rails_helper'
feature "User updates profile" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile1) { FactoryGirl.create(:profile, user: user) }

  scenario 'user navigates to edit profile page' do

    login(user)

    click_link "Profile"

    click_link "Edit Profile"

    fill_in 'Name', with: "Anna"
    fill_in 'Current location', with: "Milan, Italy"
    fill_in 'About me', with: "About to move to Rotterdam, NL"
    attach_file "Upload Image", "#{Rails.root}/spec/support/images/photo.jpg"

    click_on 'Update'

    expect(page).to have_content('Profile updated!')

    visit profile_path(profile1)

    expect(page).to have_content("Anna")
    expect(page).to have_content("Milan, Italy")
    expect(page).to have_content("About to move to Rotterdam, NL")
    expect(page).to have_css("img[src*='photo.jpg']")
  end
  scenario 'malicious user tries to edit different Profile' do
    user2 = FactoryGirl.create(:user)
    profile2 = FactoryGirl.create(:profile, user: user2)

    login(user2)

    visit edit_profile_path(profile1)

    page.has_xpath?('/')
    expect(page).to_not have_link("Update")
  end
end
