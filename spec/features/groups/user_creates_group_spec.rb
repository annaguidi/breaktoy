require 'rails_helper'
feature "User creates group" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario 'user successfully adds group without state field' do
    login(user)

    click_on "New Group"

    fill_in 'Name', with: "Hakuna Matata"
    fill_in 'City', with: "Milan"
    fill_in 'Country', with: "Italy"

    click_on 'Submit'

    expect(page).to have_content('Group added successfully!')
  end
  scenario 'user successfully adds group with state field' do
    login(user)

    click_on "New Group"

    fill_in 'Name', with: "Dora the Explorer"
    fill_in 'City', with: "Columbus"
    fill_in 'State', with: "Ohio"
    fill_in 'Country', with: "USA"

    click_on 'Submit'

    expect(page).to have_content('Group added successfully!')
  end
  scenario 'user unsuccessfully adds group' do
    login(user)

    click_link "New Group"

    click_on 'Submit'

    expect(page).to have_content("Group not added successfully! Name can't be blank, City can't be blank, Country can't be blank.")
  end
end
