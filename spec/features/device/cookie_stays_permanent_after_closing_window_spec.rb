require 'rails_helper'

RSpec.describe "Cookie stays permanent" do
  scenario "device's cookie last 'forever' after closing window" do
    device = create(:device)

    visit '/'

    time = get_me_the_cookies.first[:expires].strftime("%Y").to_i

    expected_expiration = Date.today.strftime("%Y").to_i + 20

    expect(time).to eq(expected_expiration)
  end
end
