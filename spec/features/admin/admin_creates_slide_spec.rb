require 'rails_helper'

RSpec.describe "When an admin clicks create slide" do
  it "the admin is taken to the slide creation form" do
    VCR.use_cassette "admin_creates_slide" do
      user = User.create(email: "admin@email.com", password: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/admin/devices"

      click_on "Create Custom Slide"

      
    end
  end
end
