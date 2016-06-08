require 'rails_helper'

RSpec.describe "Cookie stays permanent" do
  scenario "device's cookie last 'forever' after closing window" do
    device = create(:device)

    visit '/'

    time = get_me_the_cookies.first[:expires].strftime("%Y")

    expect(time).to eq("2036")
  end
end
