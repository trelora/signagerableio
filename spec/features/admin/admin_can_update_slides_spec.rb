require 'rails_helper'

RSpec.describe "When an admin clicks on refresh" do
  it "the slides are updated" do
    VCR.use_cassette "admin_updates_slides" do
      user = User.create(email: "admin@email.com", password: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/admin/devices"

      click_on "Refresh"

      most_recent_slides = Slide.maximum(:updated_at).strftime("%Y-%m-%d")
      most_recent_roles = Role.maximum(:updated_at).strftime("%Y-%m-%d")
      today = Time.new.strftime("%Y-%m-%d")
      expect(most_recent_slides).to eq(today)
      expect(most_recent_roles).to eq(today)
    end
  end
end
