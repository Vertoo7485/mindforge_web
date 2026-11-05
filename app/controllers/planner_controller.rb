class PlannerController < ApplicationController
  def index
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    generate_recurring_tasks(@date)
    @tasks = current_user.tasks.where(due_date: @date).order(completed: :asc, priority: :asc)
    @habits = current_user.habits
    @completed_today = @tasks.where(completed: true).count
    @total_tasks = @tasks.count
  end

  def new
    @task = current_user.tasks.build(due_date: params[:date] || Date.today)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to planner_path(date: @task.due_date), notice: "Задача добавлена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle
    @task = current_user.tasks.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to planner_path(date: @task.due_date)
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    date = @task.due_date
    @task.destroy
    redirect_to planner_path(date: date), notice: "Задача удалена"
  end

  private

  def generate_recurring_tasks(date)
    # Находим все задачи с повторением, которые были созданы раньше и ещё не имеют копии на эту дату
    recurring_tasks = current_user.tasks.where.not(recurrence: [nil, '']).where('due_date < ?', date)
    
    recurring_tasks.find_each do |task|
      next unless should_appear_on_date?(task, date)
      next if current_user.tasks.exists?(title: task.title, due_date: date)
      
      current_user.tasks.create(
        title: task.title,
        description: task.description,
        priority: task.priority,
        due_date: date,
        recurrence: task.recurrence
      )
    end
  end

  def should_appear_on_date?(task, date)
    return false unless task.due_date && task.recurrence.present?
    
    case task.recurrence
    when 'daily'
      true
    when 'weekdays'
      !date.saturday? && !date.sunday?
    when 'weekends'
      date.saturday? || date.sunday?
    else
      false
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :due_date, :recurrence)
  end
end