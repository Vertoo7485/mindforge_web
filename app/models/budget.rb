class Budget < ApplicationRecord
  belongs_to :user
  after_create :unlock_achievement_for_budget


  validates :category, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :period, presence: true, inclusion: { in: %w[monthly weekly] }


  private

  def unlock_achievement_for_budget
    achievement = Achievement.find_by(title: 'Бюджетный гуру')
    return unless achievement
    UserAchievement.find_or_create_by(user: user, achievement: achievement)
  end
end