require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) do
    Profile.new(
      avatar_url: "http://i.imgur.com/QpC6Dpl.jpg",
      location: "Ancient Greece",
      about: "Be as you wish to Github"
    )
  end

  describe ".new" do
    it "should be an Profile object" do
      expect(profile).to be_a(Profile)
    end
  end

end
