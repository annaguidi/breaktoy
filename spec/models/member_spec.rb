require 'rails_helper'

RSpec.describe Member, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group) }

  let(:member) do
    Member.new(
      user: user,
      group: group,
      owner: false
    )
  end

  describe ".new" do
    it "should be an Member object" do
      expect(member).to be_a(Member)
    end
  end
end
