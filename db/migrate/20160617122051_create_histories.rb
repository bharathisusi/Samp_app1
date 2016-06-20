class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :historiable, polymorphic: true, index: true
      t.string :title, default: ""
      t.text :description
      t.string :tags, default: ""

      t.timestamps null: false
    end
  end
end
