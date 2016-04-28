require 'rails_helper'
feature "User creates account" do
  scenario 'user navigates to sign up page' do
    visit '/users/sign_up'
    expect(page).to have_content('Sign up')
  end
  scenario 'user creates account' do
    visit '/'
    click_link 'Sign up'

    fill_in "Email", with: "derpherp@email.com"
    fill_in "Name", with: "Derpest"
    fill_in "Password", with: "derpherp"
    fill_in "Password confirmation", with: "derpherp"
    click_on "sign up"

    expect(page).to have_content("Sign out")
  end
end
