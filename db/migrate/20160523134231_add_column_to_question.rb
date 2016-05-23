class AddColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :title, :string, default: ""
  end
end
