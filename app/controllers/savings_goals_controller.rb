class SavingsGoalsController < ApplicationController
  before_action :set_goal, only: [:edit, :update, :destroy, :deposit]

  def index
    @goals = current_user.savings_goals.order(created_at: :desc)
  end

  def new
    @goal = current_user.savings_goals.build
  end

  def create
    @goal = current_user.savings_goals.build(goal_params)
    if @goal.save
      redirect_to savings_goals_path, notice: "Цель создана"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to savings_goals_path, notice: "Цель обновлена"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to savings_goals_path, notice: "Цель удалена"
  end

  def deposit
    amount = params[:amount].to_f
    if amount > 0
      @goal.update(current_amount: @goal.current_amount + amount)
      redirect_to savings_goals_path, notice: "Добавлено #{amount.to_i} ₽ к цели «#{@goal.title}»"
    else
      redirect_to savings_goals_path, alert: "Введите сумму больше 0"
    end
  end

  private

  def set_goal
    @goal = current_user.savings_goals.find(params[:id])
  end

  def goal_params
    params.require(:savings_goal).permit(:title, :target_amount, :current_amount, :deadline, :icon)
  end
end