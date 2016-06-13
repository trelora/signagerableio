class AddApiRoleToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :api_role, :string
  end
end
