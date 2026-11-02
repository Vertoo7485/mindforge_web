class BudgetsController < ApplicationController
  before_action :set_budget, only: [:edit, :update, :destroy]

  def index
    @budgets = current_user.budgets
    @month_expenses = current_user.transactions
                                 .where(transaction_type: 'expense', date: Date.today.beginning_of_month..Date.today.end_of_month)
                                 .group(:category)
                                 .sum(:amount)
  end

  def new
    @budget = current_user.budgets.build(period: 'monthly')
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: "Бюджет установлен"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: "Бюджет обновлён"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_path, notice: "Бюджет удалён"
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:category, :amount, :period)
  end
end