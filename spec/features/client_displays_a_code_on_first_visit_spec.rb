require 'rails_helper'

RSpec.describe "On the first visit to the site" do
  it "displays a screen id" do
    visit '/'

    expect(page).to have_content("Screen ID: ")
  end
end
