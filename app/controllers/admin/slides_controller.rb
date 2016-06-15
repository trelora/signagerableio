class Admin::SlidesController < ApplicationController
  def update
    Slide.update_slides
    Role.update_roles
    redirect_to admin_devices_path
  end

  def background_update
    Slide.update_slides
    Role.update_roles
  end
end
