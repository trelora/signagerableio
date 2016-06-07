class Session < ActiveRecord::Base
  validates :session_code, uniqueness: true

  def generate_session_code
    while true
      code = SecureRandom.hex(2)
      break if update(session_code: code)
    end
    session_code
  end
end
