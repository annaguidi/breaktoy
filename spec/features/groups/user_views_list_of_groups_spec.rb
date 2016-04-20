require 'rails_helper'
feature "User views list of his or her groups" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  let!(:user2) { FactoryGirl.create(:user) }
  let!(:profile2) { FactoryGirl.create(:profile, user: user2) }

  let!(:group) { FactoryGirl.create(:group) }
  let!(:group2) { FactoryGirl.create(:group)}

  let!(:member1) { FactoryGirl.create(:member, user: user, group: group) }
  let!(:member3) { FactoryGirl.create(:member, user: user, group: group2) }
  let!(:member2) { FactoryGirl.create(:member, user: user2, group: group) }

  scenario 'user successfully views groups' do
    login(user)

    click_link "See your Groups"

    expect(page).to have_link group.name
    expect(page).to have_link group2.name
  end
  scenario 'user unsuccessfully views only groups user is part of' do
    login(user2)

    click_link "See your Groups"

    expect(page).to have_link group.name
    expect(page).to_not have_link group2.name
  end
end
