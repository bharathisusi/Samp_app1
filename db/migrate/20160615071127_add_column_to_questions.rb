class AddColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_views, :string, default: ""
  end
end
