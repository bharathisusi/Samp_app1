class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :upvote
      t.integer :downvote
      t.references :votable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
