class RenameSessionsToDevice < ActiveRecord::Migration
  def change
    rename_table :sessions, :devices
  end
end
