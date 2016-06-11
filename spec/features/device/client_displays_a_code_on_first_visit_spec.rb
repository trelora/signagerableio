require 'rails_helper'

RSpec.describe "On the first visit to the site", :js => true do
  xit "displays a screen id" do
    visit '/'

    wait_for_ajax

    expect(page).to have_content("Screen ID: ")
  end
end
