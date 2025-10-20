class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.text :enunciation, null: false
      t.references :questionnaire, null: false, foreign_key: true
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :questions, [:questionnaire_id, :position]
  end
end

