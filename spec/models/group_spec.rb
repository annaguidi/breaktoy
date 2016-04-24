require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) do
    Group.new(
      name: "Tulipe",
      city: "Milano",
      country: "USA",
      latitude: 71.34455,
      longitude: -31.4356
    )
  end

  describe ".new" do
    it "should be an Group object" do
      expect(group).to be_a(Group)
    end
  end

end
