class Admin::SlidesController < ApplicationController
  def refresh
    Slide.update_slides
    Role.update_roles
    redirect_to admin_devices_path
  end
end
