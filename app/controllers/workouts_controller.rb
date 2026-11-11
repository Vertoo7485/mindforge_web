class WorkoutsController < ApplicationController
  def index
    @templates = WorkoutProgram.templates
    @my_programs = current_user.workout_programs.where(is_template: false)
    @recent_logs = current_user.workout_logs.order(date: :desc).limit(5)
  end

  def show
    @program = WorkoutProgram.find(params[:id])
    @program_exercises = @program.program_exercises.order(:order_index)
  end

  def new
    @program = current_user.workout_programs.build
    @exercises = Exercise.for_user(current_user).order(:muscle_group, :name)
  end

  def create
    @program = current_user.workout_programs.build(program_params)
    @program.is_template = false
    
    if @program.save
      # Добавляем упражнения из params
      if params[:exercise_ids].present?
        params[:exercise_ids].each_with_index do |ex_id, index|
          sets = params[:sets]&.[](index) || 3
          reps = params[:reps]&.[](index) || 10
          weight = params[:weights]&.[](index) || 0
          @program.program_exercises.create(
            exercise_id: ex_id,
            sets: sets.to_i,
            reps: reps.to_i,
            weight: weight.to_f,
            order_index: index
          )
        end
      end
      redirect_to workout_path(@program), notice: "Программа создана"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def copy
    template = WorkoutProgram.templates.find(params[:id])
    new_program = template.copy_for(current_user)
    redirect_to workout_path(new_program), notice: "Шаблон скопирован в ваши программы"
  end

  def destroy
    @program = current_user.workout_programs.find(params[:id])
    @program.destroy
    redirect_to workouts_path, notice: "Программа удалена"
  end

  private

  def program_params
    params.require(:workout_program).permit(:name, :description, :level)
  end
end