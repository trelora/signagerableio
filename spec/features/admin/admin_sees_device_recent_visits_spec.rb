require 'rails_helper'

RSpec.describe "When an admin visits admin/devices" do
  it "the admin sees the time of a devices last visit" do
    device = create(:device)
    last_visit = Time.now
    device.update(last_visit: last_visit)

    visit 'admin/devices'

    formatted_visit = last_visit.strftime("%A, %d %b %Y %l:%M %p")
    expect(page).to have_content(formatted_visit)
  end
end
