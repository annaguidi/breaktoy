require 'rails_helper'
feature "User deletes account" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario 'user navigates to edit account page' do
    login(user)

    click_on 'Edit registration'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "newpassword"
    fill_in 'Password confirmation', with: "newpassword"
    fill_in 'Current password', with: user.password

    click_on 'Update'

    expect(page).to have_content('Your account has been updated successfully')
  end
end
