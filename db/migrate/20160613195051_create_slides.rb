class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :role
      t.string :ribbon
      t.string :ribbon_color
      t.string :title
      t.string :subtitle
      t.string :best_large_image

      t.timestamps
    end
  end
end
