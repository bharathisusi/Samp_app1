class AddColDescriptionToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :description, :text
  end
end
