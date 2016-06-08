class AddRoleToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :role, :string
  end
end
