class CreateProgramExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :program_exercises do |t|
      t.references :workout_program, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :sets
      t.integer :reps
      t.decimal :weight
      t.integer :order_index

      t.timestamps
    end
  end
end
