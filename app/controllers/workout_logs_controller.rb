class WorkoutLogsController < ApplicationController
  def create
    program = current_user.workout_programs.find(params[:workout_program_id])
    @log = current_user.workout_logs.build(
      workout_program: program,
      date: Date.today,
      duration_minutes: params[:duration_minutes].to_i
    )
    
    if @log.save
      redirect_to workouts_path, notice: "Тренировка завершена! +15 XP"
    else
      redirect_to workout_path(program), alert: "Ошибка"
    end
  end
end