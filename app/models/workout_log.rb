class WorkoutLog < ApplicationRecord
  belongs_to :workout_program
  belongs_to :user

  validates :date, presence: true

  after_create :award_xp

  private

  def award_xp
    character = user.character
    character.add_xp(15)
    character.add_coins(3)
  end
end