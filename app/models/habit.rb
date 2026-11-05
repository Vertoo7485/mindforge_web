class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_completions, dependent: :destroy

  validates :name, presence: true
  validates :frequency, inclusion: { in: %w[daily weekdays weekends custom] }, allow_nil: true

  def completed_on?(date)
    habit_completions.exists?(date: date)
  end

  def streak
    count = 0
    check_date = Date.today

    loop do
      if habit_completions.exists?(date: check_date)
        count += 1
        check_date -= 1.day
      elsif check_date == Date.today
        check_date -= 1.day
        break unless habit_completions.exists?(date: check_date)
        next
      else
        break
      end
    end
    count
  end

  def week_completions(date = Date.today)
    week_start = date.beginning_of_week
    week_end = date.end_of_week
    habit_completions.where(date: week_start..week_end)
  end
end