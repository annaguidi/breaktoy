require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
    name: "Anna",
      email: "derpson@email.com",
      password: "12345678"
    )
  end

  describe ".new" do
    it "should be an User object" do
      expect(user).to be_a(User)
    end
  end
end
