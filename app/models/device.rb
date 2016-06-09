class Device < ActiveRecord::Base
  validates :device_code, uniqueness: true

  def generate_device_code
    while true
      code = SecureRandom.hex(2)
      break if update(device_code: code)
    end
    device_code
  end

  def self.roles
    service = TreloraServices.new
    service.get_roles
  end
end
