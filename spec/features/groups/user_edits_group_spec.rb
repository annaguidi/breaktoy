require 'rails_helper'
feature "User edits one of his or her groups" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  let!(:user2) { FactoryGirl.create(:user) }
  let!(:profile2) { FactoryGirl.create(:profile, user: user2) }

  let!(:group) { FactoryGirl.create(:group) }

  let!(:member1) { FactoryGirl.create(:member, user: user, group: group, owner: true) }
  let!(:member2) { FactoryGirl.create(:member, user: user2, group: group, owner: false) }

  scenario 'user successfully edits details of a group' do
    login(user)

    click_link "See your Groups"

    click_link group.name

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.city)
    expect(page).to have_content(group.country)
    expect(page).to have_content(user.profile.name)
    expect(page).to have_content(user2.profile.name)

    click_link "Edit #{group.name}"

    expect(page).to have_content("Update your Group")
    expect(page.current_path).to eq edit_group_path(group)

    fill_in 'Name', with: "Cool Kids"
    click_on 'Submit'

    expect(page).to have_content("You just updated your Group Info!")

    visit group_path(group)

    expect(page).to have_content("Cool Kids")
  end
  scenario 'user unsuccessfully edits details of a group' do
    login(user2)

    click_link "See your Groups"

    click_link group.name

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.city)
    expect(page).to have_content(group.country)
    expect(page).to have_content(user.profile.name)
    expect(page).to have_content(user2.profile.name)

    click_link "Edit #{group.name}"

    fill_in 'Name', with: "Cool Kids"
    click_on 'Submit'

    expect(page).to have_content("You do not have permission to change this group")
  end
end
