class DebtsController < ApplicationController
  before_action :set_debt, only: [:edit, :update, :destroy, :pay]

  def index
    @debts = current_user.debts.order(created_at: :desc)
    @total_debt = @debts.sum(:total_amount)
    @total_paid = @debts.sum(:paid_amount)
  end

  def new
    @debt = current_user.debts.build
  end

  def create
    @debt = current_user.debts.build(debt_params)
    if @debt.save
      redirect_to debts_path, notice: "Долг добавлен"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @debt.update(debt_params)
      redirect_to debts_path, notice: "Долг обновлён"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @debt.destroy
    redirect_to debts_path, notice: "Долг удалён"
  end

  def pay
    amount = params[:amount].to_f
    if amount > 0
      new_paid = @debt.paid_amount + amount
      @debt.update(paid_amount: new_paid)
      
      saved_months = @debt.months_saved_by(amount)
      
      message = "Погашено #{amount.to_i} ₽ по долгу «#{@debt.title}»"
      if saved_months > 0
        message += ". Срок сократился на #{saved_months} #{months_word(saved_months)}!"
      end
      
      redirect_to debts_path, notice: message
    else
      redirect_to debts_path, alert: "Введите сумму больше 0"
    end
  end

  private

  def set_debt
    @debt = current_user.debts.find(params[:id])
  end

  def debt_params
    params.require(:debt).permit(:title, :total_amount, :paid_amount, :monthly_payment, :icon)
  end

  def months_word(n)
    return 'месяц' if n % 10 == 1 && n % 100 != 11
    return 'месяца' if [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
    'месяцев'
  end
end