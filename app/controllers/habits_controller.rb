class HabitsController < ApplicationController
  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to planner_path, notice: "Привычка добавлена"
    else
      redirect_to planner_path, alert: "Ошибка: #{@habit.errors.full_messages.join(', ')}"
    end
  end

  def toggle
    @habit = current_user.habits.find(params[:id])
    date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    completion = @habit.habit_completions.find_by(date: date)
    
    if completion
      completion.destroy
    else
      @habit.habit_completions.create(date: date)
    end

    redirect_to planner_path(date: date)
  end

  def destroy
    @habit = current_user.habits.find(params[:id])
    @habit.destroy
    redirect_to planner_path, notice: "Привычка удалена"
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :frequency)
  end
end