class CreateQuestionnaires < ActiveRecord::Migration[8.0]
  def change
    create_table :questionnaires do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.text :description
      t.integer :duration_minutes, default: 30
      t.integer :total_questions, default: 0
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :questionnaires, :code, unique: true
    add_index :questionnaires, :active
  end
end





