class ChangeSessionCodeToDeviceCode < ActiveRecord::Migration
  def change
    rename_column :devices, :session_code, :device_code
  end
end
