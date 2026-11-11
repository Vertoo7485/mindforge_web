class HabitCompletion < ApplicationRecord
  belongs_to :habit

  validates :date, presence: true
  validates :habit_id, uniqueness: { scope: :date }

  after_create :award_xp
  after_create :check_achievements

  private

  def award_xp
    character = habit.user.character
    character.add_xp(Character::XP_PER_HABIT)
    character.add_coins(Character::COINS_PER_HABIT)
  end

  def check_achievements
    total = habit.user.habit_completions.count
    if total >= 100
      unlock_achievement('Король привычек')
    end
    if habit.streak >= 7
      unlock_achievement('Пламенная серия')
    end
    unlock_achievement('Рутинный герой') if habit.user.habits.count >= 1
  end

  def unlock_achievement(title)
    achievement = Achievement.find_by(title: title)
    return unless achievement
    UserAchievement.find_or_create_by(user: habit.user, achievement: achievement)
  end
end