require 'rails_helper'

RSpec.describe "When an admin clicks on refresh" do
  it "the slides are updated" do
    VCR.use_cassette "admin_updates_slides" do
      visit "/admin/devices"

      click_on "Refresh Slides"

      most_recent_update = Slide.maximum(:updated_at).strftime("%Y-%m-%d")
      today = Time.new.strftime("%Y-%m-%d")
      expect(most_recent_update).to eq(today)
    end
  end
end
