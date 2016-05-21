class AddColToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :history_id, :integer
  end
end
