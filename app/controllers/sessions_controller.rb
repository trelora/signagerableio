class SessionsController < ApplicationController
  def create
    if cookies[:session_code].nil?
      session = Session.new
      cookies[:session_code] = session.generate_session_code
    end
    redirect_to session_path(0)
  end

  def show
    @session = Session.find_by(session_code: cookies[:session_code])
  end
end
