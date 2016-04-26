require 'rails_helper'
feature "User views detail of his/her group" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  let!(:user2) { FactoryGirl.create(:user) }
  let!(:profile2) { FactoryGirl.create(:profile, user: user2) }

  let!(:group) { FactoryGirl.create(:group) }

  let!(:member1) { FactoryGirl.create(:member, user: user, group: group) }

  scenario 'user successfully views details of a group' do
    login(user)

    click_link "See your Groups"

    click_link group.name

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.city)
    expect(page).to have_content(profile.name)
  end
  scenario 'user unsucc. tries to view group details he/she is not part of' do
    login(user2)

    visit group_path(group)

    expect(page.current_path).to eq "/"

    expect(page).to have_content("You do not have permission to view these details")
  end
end
