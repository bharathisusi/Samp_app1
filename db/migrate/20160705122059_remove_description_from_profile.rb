class RemoveDescriptionFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :description, :string
  end
end
