class SavingsGoal < ApplicationRecord
  belongs_to :user

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
end