class RemoveHistoryIdFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :history_id, :integer
  end
end
