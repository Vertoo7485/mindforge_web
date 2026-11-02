class Budget < ApplicationRecord
  belongs_to :user

  validates :category, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :period, presence: true, inclusion: { in: %w[monthly weekly] }
end