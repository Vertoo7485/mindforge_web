class Task < ApplicationRecord
  belongs_to :user

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
end