require 'rails_helper'
feature "User deletes account" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario 'user navigates to edit account page' do
    login(user)

    click_on 'Edit registration'

    expect(page).to have_button('Cancel my account')
  end
  scenario 'user attempts to log in with deleted account' do
    login(user)

    click_on 'Edit registration'

    click_on 'Cancel my account'

    click_on 'Sign in'

    fill_in 'Email', with: 'herpderp@gmail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Invalid email or password')
  end
end
