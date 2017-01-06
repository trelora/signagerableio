require 'rails_helper'

RSpec.describe 'When an admin clicks edit slides' do
  let(:user) {User.create(email: "admin@email.com", password: "password")}
  it 'the admin is taken to the slide index where any slide can be edited' do
    VCR.use_cassette 'admin_edits_slide' do
      slide = create_custom_slide
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/admin/devices'

      click_on 'See All Custom Slides'

      click_on 'Edit'

      fill_in 'slide_title', with: 'New Title'
      fill_in 'slide_subtitle', with: 'New Subtitle'
      fill_in 'slide_display_rate', with: '7'
      click_on 'Preview Slide'

      expect(current_url).to eq("http://www.example.com/admin/slides/#{Slide.last.id}")
      expect(page).to have_content('New Title')
      expect(page).to have_content('New Subtitle')
      expect(page).to have_button('Edit Slide')
      expect(page).to have_button('Save Slide')

      click_on 'Save Slide'

      expect(current_url).to eq('http://www.example.com/admin/devices')
      expect(page).to have_content('Custom Slide Successfully Saved')
      expect(page).to have_content('Custom Slides Currently in Active Rotation: 1')
    end
  end
end
