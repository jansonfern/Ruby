class CreateQuestionOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :question_options do |t|
      t.string :title, null: false
      t.boolean :correct, default: false
      t.references :question, null: false, foreign_key: true
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :question_options, [:question_id, :position]
    add_index :question_options, [:question_id, :correct]
  end
end

