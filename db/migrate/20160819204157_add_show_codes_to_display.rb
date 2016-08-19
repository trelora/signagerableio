class AddShowCodesToDisplay < ActiveRecord::Migration
  def change
    add_column :displays, :show_device_codes, :boolean, null: false, default: false
  end
end
