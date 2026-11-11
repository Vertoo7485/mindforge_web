class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :savings_goals, dependent: :destroy
  has_many :debts, dependent: :destroy
  has_one :financial_profile, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :habits, dependent: :destroy
  has_one :character, dependent: :destroy
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements
  has_many :exercises, dependent: :destroy
  has_many :workout_programs, dependent: :destroy
  has_many :workout_logs, dependent: :destroy

  def character
    super || create_character(level: 1, xp: 0, xp_to_next_level: 100, coins: 0)
  end
end