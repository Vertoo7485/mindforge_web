class SavingsGoal < ApplicationRecord
  belongs_to :user
  after_create :unlock_achievement_for_goal

  validates :title, presence: true
  validates :target_amount, presence: true, numericality: { greater_than: 0 }
  validates :current_amount, numericality: { greater_than_or_equal_to: 0 }

  def percent
    return 0 if target_amount <= 0
    [(current_amount / target_amount * 100).round, 100].min
  end

  def remaining
    [target_amount - current_amount, 0].max
  end

  def completed?
    current_amount >= target_amount
  end

  private

  def unlock_achievement_for_goal
    achievement = Achievement.find_by(title: 'Накопитель')
    return unless achievement
    UserAchievement.find_or_create_by(user: user, achievement: achievement)
  end
end