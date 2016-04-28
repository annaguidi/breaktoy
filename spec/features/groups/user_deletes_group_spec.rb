require 'rails_helper'
feature "User deletes his/her group" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  let!(:user2) { FactoryGirl.create(:user) }
  let!(:profile2) { FactoryGirl.create(:profile, user: user2) }

  let!(:group) { FactoryGirl.create(:group) }

  let!(:member1) { FactoryGirl.create(:member, user: user, group: group, owner: true) }
  let!(:member2) { FactoryGirl.create(:member, user: user2, group: group, owner: false) }

  scenario 'user successfully deletes a group' do
    login(user)

    click_link "See your Groups"

    click_link group.name

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.city)
    expect(page).to have_content(user.name)

    click_button "Delete"

    expect(page).to have_content("Group Deleted Successfully")
  end
  scenario 'user unsucc. tries to delete group' do
    login(user2)

    click_link "See your Groups"

    click_link group.name

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.city)
    expect(page).to have_content(user.name)

    click_button "Delete"

    expect(page).to have_content("You do not have permission to delete this group")
  end
end
