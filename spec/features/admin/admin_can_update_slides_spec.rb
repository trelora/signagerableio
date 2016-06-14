require 'rails_helper'

RSpec.describe "When an admin clicks on refresh" do
  it "the slides are updated" do
    VCR.use_cassette "admin_updates_slides" do
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
