class FinanceController < ApplicationController
  before_action :set_transaction, only: [:edit, :update, :destroy]

    def index
    @transactions = current_user.transactions

    case params[:period]
    when 'week'
      @transactions = @transactions.where(date: 1.week.ago..Date.today)
    when 'month'
      @transactions = @transactions.where(date: 1.month.ago..Date.today)
    when 'year'
      @transactions = @transactions.where(date: 1.year.ago..Date.today)
    end

    @balance = current_user.transactions.sum do |t|
      t.transaction_type == 'income' ? t.amount : -t.amount
    end

    @expenses_by_category = @transactions
                              .where(transaction_type: 'expense')
                              .group(:category)
                              .sum(:amount)

    @incomes_by_category = @transactions
                             .where(transaction_type: 'income')
                             .group(:category)
                             .sum(:amount)

    @transactions = @transactions.order(date: :desc)
    @period = params[:period] || 'all'
  end

  def new
    @transaction = current_user.transactions.build(date: Date.today)
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to finance_path, notice: "Транзакция добавлена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to finance_path, notice: "Транзакция обновлена"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to finance_path, notice: "Транзакция удалена"
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, :category, :date, :note)
  end
end 