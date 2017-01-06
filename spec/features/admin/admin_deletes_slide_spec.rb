require 'rails_helper'

RSpec.describe 'When an admin clicks delete slide' do
  let(:user) {User.create(email: "admin@email.com", password: "password")}
  it 'the admin deletes the slide from the system' do
    VCR.use_cassette 'admin_deletes_slide' do
      slide = create_custom_slide
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/admin/slides'

      click_on 'Delete'

      expect(current_url).to eq('http://www.example.com/admin/slides')
      expect(page).to have_content('Custom Slide Successfully Deleted')
    end
  end
end
