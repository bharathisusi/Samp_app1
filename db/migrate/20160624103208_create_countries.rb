class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :phone_country_code
      t.string :currency

      t.timestamps null: false
    end
  end
end
