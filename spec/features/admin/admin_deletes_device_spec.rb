require 'rails_helper'

RSpec.describe "When an admin clicks delete" do
  it "the device is deleted from the database" do
    device = create(:device)
    expect(Device.count).to eq(1)

    visit '/admin/devices'
    click_on "Delete"

    expect(current_path).to eq("/admin/devices")
    expect(page).not_to have_content(device.id)
    expect(Device.count).to eq(0)
  end
end
