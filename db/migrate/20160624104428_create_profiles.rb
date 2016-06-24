class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :image
      t.string :tag
      t.string :organization
      t.string :description
      t.integer :country
      t.integer :state
      t.string :city

      t.timestamps null: false
    end
  end
end
