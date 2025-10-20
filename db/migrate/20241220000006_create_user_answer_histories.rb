class CreateUserAnswerHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :user_answer_histories do |t|
      t.references :user_result, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, null: false, foreign_key: true
      t.boolean :correct, default: false

      t.timestamps
    end

    add_index :user_answer_histories, [:user_result_id, :question_id], unique: true
    add_index :user_answer_histories, :correct
  end
end





