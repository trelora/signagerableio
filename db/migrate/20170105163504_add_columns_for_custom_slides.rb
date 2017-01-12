class AddColumnsForCustomSlides < ActiveRecord::Migration
  def change
    add_column :slides, :ribbon_display, :boolean, default: :false
    add_column :slides, :active, :boolean, default: :true
    add_column :slides, :display_rate, :integer
    add_column :slides, :custom_background, :string
    add_column :slides, :custom, :boolean, default: :false
  end
end
