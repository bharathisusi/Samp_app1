class RemoveImageFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :image, :string
  end
end
