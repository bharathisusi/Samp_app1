class RemoveHistoryIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :history_id, :integer
  end
end
