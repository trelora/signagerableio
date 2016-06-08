require 'rails_helper'

RSpec.describe "Cookie stays permanent" do
  scenario "device's cookie last 'forever' after closing window" do
    device = FactoryGirl.create(:device)

    visit '/'

    time = get_me_the_cookies.first[:expires].strftime("%B %d, %Y")

    expect(time).to eq("June 08, 2036")
  end
end
