class Character < ApplicationRecord
  belongs_to :user

  validates :level, numericality: { greater_than: 0 }
  validates :xp, numericality: { greater_than_or_equal_to: 0 }
  validates :coins, numericality: { greater_than_or_equal_to: 0 }

  XP_PER_TASK = 10
  XP_PER_HABIT = 5
  XP_PER_TRANSACTION = 3
  COINS_PER_TASK = 2
  COINS_PER_HABIT = 1
  COINS_PER_TRANSACTION = 1

  def add_xp(amount)
    self.xp += amount
    level_up while xp >= xp_to_next_level
    save
  end

  def add_coins(amount)
    self.coins += amount
    save
  end

  def level_up
    self.xp -= xp_to_next_level
    self.level += 1
    self.xp_to_next_level = (xp_to_next_level * 1.5).round
  end

  def xp_percent
    return 0 if xp_to_next_level <= 0
    [(xp.to_f / xp_to_next_level * 100).round, 100].min
  end

  def rank
    case level
    when 1..4 then 'Новичок'
    when 5..9 then 'Странник'
    when 10..19 then 'Воин'
    when 20..34 then 'Ветеран'
    when 35..49 then 'Мастер'
    else 'Легенда'
    end
  end
end