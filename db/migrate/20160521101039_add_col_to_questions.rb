class AddColToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :history_id, :integer
  end
end
