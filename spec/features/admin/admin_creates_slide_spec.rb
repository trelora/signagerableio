require 'rails_helper'

RSpec.describe 'When an admin clicks create slide' do
  let(:user) {User.create(email: "admin@email.com", password: "password")}
  it 'the admin is taken to the slide creation form' do
    VCR.use_cassette 'admin_creates_slide' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/admin/devices'

      click_on 'Create Custom Slide'

      fill_in 'slide_title', with: 'Test Title'
      fill_in 'slide_subtitle', with: 'Test Subtitle'
      fill_in 'slide_display_rate', with: '5'
      click_on 'Preview Slide'

      expect(current_url).to eq("http://www.example.com/admin/slides/#{Slide.last.id}")
      expect(page).to have_button('Edit Slide')
      expect(page).to have_button('Save Slide')

      click_on 'Save Slide'

      expect(current_url).to eq('http://www.example.com/admin/devices')
      expect(page).to have_content('Custom Slide Successfully Saved')
      expect(page).to have_content('Custom Slides Currently in Active Rotation: 1')
    end
  end
end
