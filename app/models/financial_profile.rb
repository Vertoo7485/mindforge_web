class FinancialProfile < ApplicationRecord
  belongs_to :user

  validates :monthly_income, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :monthly_expenses, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :savings_goal, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def disposable_income
    (monthly_income || 0) - (monthly_expenses || 0)
  end

  def savings_rate
    return 0 if monthly_income.to_f <= 0
    ((disposable_income / monthly_income) * 100).round(1)
  end

  def months_to_goal
    return 0 if savings_goal.to_f <= 0 || disposable_income <= 0
    (savings_goal / disposable_income).ceil
  end

  def health_score
    score = 0
    score += 30 if savings_rate >= 20
    score += 20 if savings_rate >= 10 && savings_rate < 20
    score += 10 if savings_rate > 0 && savings_rate < 10
    score += 30 if (monthly_expenses.to_f > 0) && (monthly_income.to_f / monthly_expenses.to_f) >= 3
    score += 20 if (monthly_expenses.to_f > 0) && (monthly_income.to_f / monthly_expenses.to_f) >= 2
    score += 20 if risk_level.present?
    [score, 100].min
  end

  def recommendations
    recs = []
    
    if savings_rate < 10
      recs << { icon: '⚠️', title: 'Низкая норма сбережений', text: 'Вы откладываете менее 10% дохода. Попробуйте начать с 5-10% — даже небольшие суммы создают привычку.' }
    elsif savings_rate >= 20
      recs << { icon: '✅', title: 'Отличная норма сбережений', text: "Вы откладываете #{savings_rate}% дохода. Это выше рекомендованных 20%. Продолжайте!" }
    end

    if disposable_income <= 0
      recs << { icon: '🚨', title: 'Расходы превышают доходы', text: 'Вы тратите больше, чем зарабатываете. Это опасно. Пересмотрите крупные траты и найдите, что можно сократить.' }
    end

    if monthly_income.to_f > 0 && (monthly_expenses.to_f / monthly_income.to_f) > 0.8
      recs << { icon: '📊', title: 'Высокая доля расходов', text: 'Расходы превышают 80% дохода. Рекомендуется держать их ниже 70%.' }
    end

    if savings_goal.to_f > 0 && months_to_goal > 0
      recs << { icon: '🎯', title: "Цель: #{months_to_goal} мес.", text: "При текущей норме сбережений вы достигнете цели за #{months_to_goal} #{months_word(months_to_goal)}." }
    end

    if risk_level == 'low'
      recs << { icon: '🛡️', title: 'Консервативный подход', text: 'Вы предпочитаете надёжность. Держите подушку безопасности в 6 месяцев расходов и рассмотрите вклады.' }
    elsif risk_level == 'medium'
      recs << { icon: '⚖️', title: 'Сбалансированный подход', text: 'Вы готовы к умеренному риску. Рассмотрите диверсификацию: часть в надёжные инструменты, часть — в рост.' }
    elsif risk_level == 'high'
      recs << { icon: '🚀', title: 'Агрессивный подход', text: 'Вы готовы к высокому риску. Убедитесь, что у вас есть подушка безопасности, прежде чем инвестировать в волатильные активы.' }
    end

    recs
  end

  private

  def months_word(n)
    return 'месяц' if n % 10 == 1 && n % 100 != 11
    return 'месяца' if [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
    'месяцев'
  end
end