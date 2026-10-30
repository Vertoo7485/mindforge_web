class Transaction < ApplicationRecord
  belongs_to :user

  validates :transaction_type, presence: true, inclusion: { in: %w[income expense] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :date, presence: true
end