require 'rails_helper'

RSpec.describe Marker, type: :model do
  let!(:member) { FactoryGirl.create(:member) }

  let(:marker) do
    Marker.new(
      member: member,
      title: "Hole in the Wall",
      description: "Wonderful second hand store",
      img_url: "https://pbs.twimg.com/profile_images/730703875/twitter5.jpg",
      address: "10 Cherry Lane",
      city: "Madison",
      state: "CT",
      zip_code: "06346",
      latitude: 51.508742,
      longitude: -0.120850
    )
  end

  describe ".new" do
    it "should be an Marker object" do
      expect(marker).to be_a(Marker)
    end
  end
end
