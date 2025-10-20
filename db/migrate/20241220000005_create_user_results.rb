class CreateUserResults < ActiveRecord::Migration[8.0]
  def change
    create_table :user_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :questionnaire, null: false, foreign_key: true
      t.integer :score, default: 0
      t.string :grade, default: 'F'
      t.datetime :submitted_at

      t.timestamps
    end

    add_index :user_results, [:user_id, :questionnaire_id], unique: true
    add_index :user_results, :submitted_at
    add_index :user_results, :grade
  end
end





