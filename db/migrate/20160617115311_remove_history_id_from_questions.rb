class RemoveHistoryIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :history_id, :integer
  end
end
