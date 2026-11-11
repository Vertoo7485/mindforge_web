class Transaction < ApplicationRecord
  belongs_to :user

  validates :transaction_type, presence: true, inclusion: { in: %w[income expense] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :date, presence: true

  after_create :award_xp
  after_create :check_achievements

  private

  def award_xp
    character = user.character
    character.add_xp(Character::XP_PER_TRANSACTION)
    character.add_coins(Character::COINS_PER_TRANSACTION)
  end

  def check_achievements
    if transaction_type == 'expense' && user.transactions.where(transaction_type: 'expense').count >= 1
      unlock_achievement('Транжира')
    end
    if transaction_type == 'income' && user.transactions.where(transaction_type: 'income').count >= 1
      unlock_achievement('Капиталист')
    end
    if user.transactions.count >= 20
      unlock_achievement('Аналитик')
    end
  end

  def unlock_achievement(title)
    achievement = Achievement.find_by(title: title)
    return unless achievement
    UserAchievement.find_or_create_by(user: user, achievement: achievement)
  end
end