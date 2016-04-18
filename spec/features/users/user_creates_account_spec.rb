# I should be able to sign up for an account using a link which I can find on
# the root page

# [X] I should be able to specify my email, password, password confirmation
# [X] I should be able to login to my account
# [X] I should be able to logout of my account

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
    fill_in "Password", with: "derpherp"
    fill_in "Password confirmation", with: "derpherp"
    click_on "sign up"

    expect(page).to have_content("Sign out")
  end
end
