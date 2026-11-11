class CreateWorkoutLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_logs do |t|
      t.references :workout_program, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.integer :duration_minutes

      t.timestamps
    end
  end
end
