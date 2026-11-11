class WorkoutProgram < ApplicationRecord
  belongs_to :user, optional: true
  has_many :program_exercises, dependent: :destroy
  has_many :exercises, through: :program_exercises
  has_many :workout_logs, dependent: :destroy

  validates :name, presence: true

  LEVELS = {
    'beginner' => 'Новичок',
    'intermediate' => 'Средний',
    'advanced' => 'Продвинутый'
  }.freeze

  scope :templates, -> { where(is_template: true) }
  scope :user_programs, ->(user) { where(user_id: user.id, is_template: false) }

  def level_label
    LEVELS[level] || level
  end

  def is_template?
    is_template
  end

  def copy_for(user)
    new_program = user.workout_programs.create(
      name: name,
      description: description,
      level: level,
      is_template: false
    )
    
    program_exercises.each do |pe|
      new_program.program_exercises.create(
        exercise_id: pe.exercise_id,
        sets: pe.sets,
        reps: pe.reps,
        weight: pe.weight,
        order_index: pe.order_index
      )
    end
    
    new_program
  end
end