class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_filter :ensure_display_exists

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_display_exists
    if Display.count > 1
      Display.where(id: (Display.pluck(:id) - [Display.last.id])).delete_all
    elsif Display.count < 1
      Display.create(time: 1)
    end
  end

  def authorize!
    redirect_to login_path unless current_user
  end

  def create_device
    device = Device.new
    cookies.permanent[:device_code] = device.generate_device_code
    cookies.permanent[:counter] = 1
    device
  end

  def destroy_all_pending_slides!
    Slide.where('role LIKE ?', '%pending%').destroy_all
  end
end
