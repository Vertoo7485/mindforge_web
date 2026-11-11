class Task < ApplicationRecord
  belongs_to :user
  after_update :award_xp_for_completion, if: :saved_change_to_completed?

  validates :title, presence: true
  validates :priority, inclusion: { in: %w[low medium high] }, allow_nil: true

  scope :for_date, ->(date) { where(due_date: date) }
  scope :incomplete, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }

  def priority_color
    case priority
    when 'high' then '#e15554'
    when 'medium' then '#e8b84b'
    else '#4ecdc4'
    end
  end

  def priority_label
    case priority
    when 'high' then 'Высокий'
    when 'medium' then 'Средний'
    when 'low' then 'Низкий'
    else 'Средний'
    end
  end

  private

  def award_xp_for_completion
    return unless completed?
    
    character = user.character
    character.add_xp(Character::XP_PER_TASK)
    character.add_coins(Character::COINS_PER_TASK)
    
    check_achievements
  end

  def check_achievements
    completed_count = user.tasks.where(completed: true).count
    
    if completed_count >= 1
      unlock_achievement('Первые шаги')
    end
    if completed_count >= 50
      unlock_achievement('Мастер задач')
    end
    if completed_count >= 5 && user.tasks.where(completed: true, due_date: Date.today).count >= 5
      unlock_achievement('Продуктивный день')
    end
    if priority == 'high'
      unlock_achievement('Стрелок')
    end
    if user.character.level >= 2
      unlock_achievement('Путь воина')
    end
  end

  def unlock_achievement(title)
    achievement = Achievement.find_by(title: title)
    return unless achievement
    UserAchievement.find_or_create_by(user: user, achievement: achievement)
  end
end