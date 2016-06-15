require 'rails_helper'

RSpec.describe "When an admin clicks on a device" do
  let(:user) {User.create(email: "admin@email.com", password: "password")}

  it "they are able to give the device a nickname" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    device = create(:device)

    visit '/admin/devices'
    click_on "#{device.id}"
    fill_in "device[nickname]", with: "Meeting Room 1"
    click_on "Submit"

    expect(current_path).to eq("/admin/devices")
    expect(page).to have_content("Meeting Room 1")
  end

  it "they are able to give the device a role" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    Role.update_roles
    device = create(:device)

    visit '/admin/devices'
    click_on "#{device.id}"

    select "comingsoon", :from => "device[role]"
    click_on "Submit"

    expect(current_path).to eq("/admin/devices")
    expect(page).to have_content("comingsoon")
  end

  it "they are able to set the device code" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    device = create(:device)

    visit '/admin/devices'
    click_on "#{device.id}"

    fill_in "device[device_code]", with: "1234"
    click_on "Submit"

    expect(current_path).to eq("/admin/devices")
    expect(page).not_to have_content(device.device_code)
    expect(page).to have_content("1234")
  end
end
