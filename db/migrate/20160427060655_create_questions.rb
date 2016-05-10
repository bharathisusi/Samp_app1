class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question_box

      t.timestamps null: false
    end
  end
end
