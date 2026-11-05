class Debt < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :paid_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :monthly_payment, numericality: { greater_than_or_equal_to: 0 }

  def remaining
    [total_amount - paid_amount, 0].max
  end

  def percent
    return 0 if total_amount <= 0
    [(paid_amount / total_amount * 100).round, 100].min
  end

  def completed?
    paid_amount >= total_amount
  end

  def months_left
    return 0 if monthly_payment <= 0 || remaining <= 0
    (remaining / monthly_payment).ceil
  end

  def months_saved_by(extra_payment)
    return 0 if monthly_payment <= 0 || extra_payment <= 0
    months_before = months_left
    new_remaining = remaining - extra_payment
    return months_before if new_remaining <= 0
    months_after = (new_remaining / monthly_payment).ceil
    [months_before - months_after, 0].max
  end
end