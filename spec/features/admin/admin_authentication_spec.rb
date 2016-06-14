require 'rails_helper'

RSpec.describe "Admin Authentication" do

  let(:admin) {User.create(email: "admin@example.com", password: "password")}

  it "admin logs in" do
    visit login_path

    fill_in 'session[email]', :with => admin.email
    fill_in 'session[password]', :with => admin.password

    click_on "Login"

    expect(current_path).to eq(admin_devices_path)
  end

  it "does not allow invalid credentials" do
    visit login_path

    fill_in 'session[email]', :with => admin.email
    fill_in 'session[password]', :with => "invalid"

    click_on "Login"

    expect(current_path).to eq(login_path)
  end
end
