class AnalyticsController < ApplicationController
  def index
    @period = params[:period] || 'month'
    
    case @period
    when 'week'
      start_date = 1.week.ago.to_date
    when 'month'
      start_date = 1.month.ago.to_date
    when 'year'
      start_date = 1.year.ago.to_date
    else
      start_date = Date.new(2000, 1, 1)
    end

    @transactions = current_user.transactions
                               .where(date: start_date..Date.today)

    @expenses_by_category = @transactions
                              .where(transaction_type: 'expense')
                              .group(:category)
                              .sum(:amount)
                              .sort_by { |_, v| -v }
                              .to_h

    @incomes_by_category = @transactions
                             .where(transaction_type: 'income')
                             .group(:category)
                             .sum(:amount)

    # По месяцам (последние 6 месяцев)
    @monthly_data = {}
    6.times do |i|
      month_start = (Date.today - i.months).beginning_of_month
      month_end = month_start.end_of_month
      month_key = month_start.strftime("%m.%Y")
      
      income = current_user.transactions
                           .where(transaction_type: 'income', date: month_start..month_end)
                           .sum(:amount)
      expense = current_user.transactions
                            .where(transaction_type: 'expense', date: month_start..month_end)
                            .sum(:amount)
      
      @monthly_data[month_key] = { income: income, expense: expense }
    end
    @monthly_data = @monthly_data.to_a.reverse.to_h

    @total_income = @transactions.where(transaction_type: 'income').sum(:amount)
    @total_expense = @transactions.where(transaction_type: 'expense').sum(:amount)
  end
end