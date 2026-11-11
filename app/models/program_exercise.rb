class ProgramExercise < ApplicationRecord
  belongs_to :workout_program
  belongs_to :exercise

  validates :sets, numericality: { greater_than: 0 }, allow_nil: true
  validates :reps, numericality: { greater_than: 0 }, allow_nil: true
end