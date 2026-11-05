class HabitCompletion < ApplicationRecord
  belongs_to :habit

  validates :date, presence: true
  validates :habit_id, uniqueness: { scope: :date }
end