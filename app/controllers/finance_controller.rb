class FinanceController < ApplicationController
  def index
    @transactions = current_user.transactions.order(date: :desc)
    @balance = current_user.transactions.sum do |t|
      t.transaction_type == 'income' ? t.amount : -t.amount
    end
    @expenses_by_category = current_user.transactions
                                        .where(transaction_type: 'expense')
                                        .group(:category)
                                        .sum(:amount)
  end

  def new
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to finance_path, notice: "Транзакция добавлена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, :category, :date, :note)
  end
end