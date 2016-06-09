class AddLastVisitToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :last_visit, :string
  end
end
