require 'rails_helper'


RSpec.describe "When the admin visits the device#index" do
  it "they can set the time per slide" do
    user = User.create(email: "admin@email.com", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    display = Display.create(time: 1)

    visit '/admin/devices'
    expect(page).to have_content("Current Slide Time: 1 second(s) per slide")

    fill_in "display[time]", :with => "2"
    click_on 'Submit'

    expect(current_path).to eq('/admin/devices')
    expect(page).to have_content("Current Slide Time: 2 second(s) per slide")
  end
end
