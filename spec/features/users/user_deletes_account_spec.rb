require 'rails_helper'
feature "User deletes account" do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user navigates to edit account page' do
    user_login

    click_on 'Edit registration'

    expect(page).to have_content('Cancel my account')
  end

  scenario 'user attempts to log in with deleted account' do
    user_login

    click_on 'Edit registration'

    click_on 'Cancel my account'

    click_on 'Sign in'

    fill_in 'Email', with: 'herpderp@gmail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Invalid email or password')
  end
end
