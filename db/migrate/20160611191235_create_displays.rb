class CreateDisplays < ActiveRecord::Migration
  def change
    create_table :displays do |t|
      t.integer :time
    end
  end
end
