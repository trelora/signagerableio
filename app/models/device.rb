class Device < ActiveRecord::Base
  validates :device_code, uniqueness: true

  before_save :set_default_role

  def set_default_role
    if self.role.blank?
      self.role = (Role.find_by(role: "sold") || Role.last).role
    end
  end

  def seen!
    self.update(last_visit: Time.now.to_s)
  end

  def generate_device_code
    while true
      code = SecureRandom.hex(2)
      break if update(device_code: code)
    end
    device_code
  end
end
