class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :historiable, polymorphic: true, index: true
      t.string :title
      t.text :description
      t.string :tags

      t.timestamps null: false
    end
  end
end
