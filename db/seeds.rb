# achievements = [
#   { title: 'Первые шаги', description: 'Выполните первую задачу', icon: '🎯', condition_type: 'tasks_completed', condition_value: 1 },
#   { title: 'Транжира', description: 'Добавьте первый расход', icon: '💸', condition_type: 'expenses_count', condition_value: 1 },
#   { title: 'Капиталист', description: 'Добавьте первый доход', icon: '💰', condition_type: 'incomes_count', condition_value: 1 },
#   { title: 'Пламенная серия', description: 'Отметьте привычку 7 дней подряд', icon: '🔥', condition_type: 'habit_streak', condition_value: 7 },
#   { title: 'Продуктивный день', description: 'Выполните 5 задач за день', icon: '⚔️', condition_type: 'tasks_per_day', condition_value: 5 },
#   { title: 'Путь воина', description: 'Достигните 2 уровня', icon: '🏆', condition_type: 'level', condition_value: 2 },
#   { title: 'Мастер задач', description: 'Выполните 50 задач', icon: '✅', condition_type: 'tasks_completed', condition_value: 50 },
#   { title: 'Король привычек', description: 'Отметьте 100 привычек', icon: '👑', condition_type: 'habits_completed', condition_value: 100 },
#   { title: 'Накопитель', description: 'Создайте цель накопления', icon: '🎯', condition_type: 'savings_goals_count', condition_value: 1 },
#   { title: 'Борец с долгами', description: 'Погасите долг полностью', icon: '🛡️', condition_type: 'debts_completed', condition_value: 1 },
#   { title: 'Планировщик', description: 'Создайте 10 задач', icon: '📋', condition_type: 'tasks_created', condition_value: 10 },
#   { title: 'Аналитик', description: 'Добавьте 20 транзакций', icon: '📊', condition_type: 'transactions_count', condition_value: 20 },
#   { title: 'Стрелок', description: 'Выполните задачу с высоким приоритетом', icon: '🎪', condition_type: 'high_priority_tasks', condition_value: 1 },
#   { title: 'Рутинный герой', description: 'Создайте привычку', icon: '🔄', condition_type: 'habits_created', condition_value: 1 },
#   { title: 'Бюджетный гуру', description: 'Установите бюджет', icon: '💼', condition_type: 'budgets_count', condition_value: 1 },
#   { title: 'Финансовый маг', description: 'Достигните 5 уровня', icon: '🧙', condition_type: 'level', condition_value: 5 }
# ]

# achievements.each do |a|
#   Achievement.find_or_create_by(title: a[:title]) do |ach|
#     ach.assign_attributes(a)
#   end
# end

# puts "Создано #{Achievement.count} достижений"
#

# ===== ГЛОБАЛЬНАЯ БИБЛИОТЕКА УПРАЖНЕНИЙ =====
if Exercise.global.empty?
  exercises = [
    # Грудь
    { name: 'Жим штанги лёжа', muscle_group: 'chest' },
    { name: 'Жим гантелей лёжа', muscle_group: 'chest' },
    { name: 'Жим в тренажёре', muscle_group: 'chest' },
    { name: 'Разводка гантелей лёжа', muscle_group: 'chest' },
    { name: 'Отжимания на брусьях', muscle_group: 'chest' },
    { name: 'Отжимания от пола', muscle_group: 'chest' },
    { name: 'Кроссовер', muscle_group: 'chest' },
    # Спина
    { name: 'Становая тяга', muscle_group: 'back' },
    { name: 'Тяга штанги в наклоне', muscle_group: 'back' },
    { name: 'Тяга верхнего блока', muscle_group: 'back' },
    { name: 'Подтягивания', muscle_group: 'back' },
    { name: 'Тяга гантели одной рукой', muscle_group: 'back' },
    { name: 'Горизонтальная тяга', muscle_group: 'back' },
    { name: 'Шраги с гантелями', muscle_group: 'back' },
    # Ноги
    { name: 'Приседания со штангой', muscle_group: 'legs' },
    { name: 'Жим ногами', muscle_group: 'legs' },
    { name: 'Румынская тяга', muscle_group: 'legs' },
    { name: 'Выпады с гантелями', muscle_group: 'legs' },
    { name: 'Разгибание ног в тренажёре', muscle_group: 'legs' },
    { name: 'Сгибание ног в тренажёре', muscle_group: 'legs' },
    { name: 'Подъём на носки', muscle_group: 'legs' },
    # Плечи
    { name: 'Жим штанги стоя', muscle_group: 'shoulders' },
    { name: 'Жим гантелей сидя', muscle_group: 'shoulders' },
    { name: 'Махи гантелями в стороны', muscle_group: 'shoulders' },
    { name: 'Тяга штанги к подбородку', muscle_group: 'shoulders' },
    { name: 'Разводка в наклоне', muscle_group: 'shoulders' },
    # Руки
    { name: 'Подъём штанги на бицепс', muscle_group: 'arms' },
    { name: 'Сгибание рук с гантелями', muscle_group: 'arms' },
    { name: 'Молотковые сгибания', muscle_group: 'arms' },
    { name: 'Французский жим', muscle_group: 'arms' },
    { name: 'Разгибание рук на блоке', muscle_group: 'arms' },
    { name: 'Отжимания узким хватом', muscle_group: 'arms' },
    # Пресс
    { name: 'Скручивания', muscle_group: 'core' },
    { name: 'Планка', muscle_group: 'core' },
    { name: 'Подъём ног в висе', muscle_group: 'core' },
    { name: 'Велосипед', muscle_group: 'core' },
    { name: 'Русский твист', muscle_group: 'core' },
    # Кардио
    { name: 'Бег на дорожке', muscle_group: 'cardio' },
    { name: 'Гребной тренажёр', muscle_group: 'cardio' },
    { name: 'Скакалка', muscle_group: 'cardio' },
    { name: 'Велотренажёр', muscle_group: 'cardio' },
    # Фулбади
    { name: 'Бёрпи', muscle_group: 'fullbody' },
    { name: 'Трастеры', muscle_group: 'fullbody' },
    { name: 'Гиревой свинг', muscle_group: 'fullbody' }
  ]

  exercises.each do |ex|
    Exercise.create!(ex.merge(user_id: nil))
  end
  puts "Создано #{Exercise.global.count} упражнений"
end

# ===== ШАБЛОНЫ ПРОГРАММ =====
if WorkoutProgram.templates.empty?
  # 1. Фулбади для новичков
  fullbody = WorkoutProgram.create!(
    name: 'Фулбади для новичков',
    description: 'Всё тело за одну тренировку. 3 раза в неделю. Идеально для старта.',
    level: 'beginner',
    is_template: true,
    user_id: nil
  )
  [
    { name: 'Приседания со штангой', sets: 3, reps: 10 },
    { name: 'Жим штанги лёжа', sets: 3, reps: 10 },
    { name: 'Тяга штанги в наклоне', sets: 3, reps: 10 },
    { name: 'Жим гантелей сидя', sets: 3, reps: 12 },
    { name: 'Планка', sets: 3, reps: 45 }
  ].each_with_index do |item, i|
    ex = Exercise.global.find_by(name: item[:name])
    fullbody.program_exercises.create!(exercise: ex, sets: item[:sets], reps: item[:reps], weight: 0, order_index: i) if ex
  end

  # 2. Силовая классика (3-дневный сплит)
  strength = WorkoutProgram.create!(
    name: 'Силовая классика',
    description: 'Классический 3-дневный сплит: жим, тяга, присед. Для набора силы.',
    level: 'intermediate',
    is_template: true,
    user_id: nil
  )
  [
    { name: 'Приседания со штангой', sets: 5, reps: 5 },
    { name: 'Жим штанги лёжа', sets: 5, reps: 5 },
    { name: 'Становая тяга', sets: 3, reps: 5 },
    { name: 'Тяга штанги в наклоне', sets: 4, reps: 8 },
    { name: 'Подъём штанги на бицепс', sets: 3, reps: 10 }
  ].each_with_index do |item, i|
    ex = Exercise.global.find_by(name: item[:name])
    strength.program_exercises.create!(exercise: ex, sets: item[:sets], reps: item[:reps], weight: 0, order_index: i) if ex
  end

  # 3. Верх тела
  upper = WorkoutProgram.create!(
    name: 'Верх тела',
    description: 'Грудь, спина, плечи, руки. Для тех, кто качает верх.',
    level: 'beginner',
    is_template: true,
    user_id: nil
  )
  [
    { name: 'Жим штанги лёжа', sets: 4, reps: 10 },
    { name: 'Тяга верхнего блока', sets: 4, reps: 12 },
    { name: 'Жим гантелей сидя', sets: 3, reps: 10 },
    { name: 'Подъём штанги на бицепс', sets: 3, reps: 12 },
    { name: 'Французский жим', sets: 3, reps: 12 }
  ].each_with_index do |item, i|
    ex = Exercise.global.find_by(name: item[:name])
    upper.program_exercises.create!(exercise: ex, sets: item[:sets], reps: item[:reps], weight: 0, order_index: i) if ex
  end

  # 4. Низ тела
  lower = WorkoutProgram.create!(
    name: 'Низ тела',
    description: 'Ноги, ягодицы, пресс. День ног, который ты полюбишь.',
    level: 'beginner',
    is_template: true,
    user_id: nil
  )
  [
    { name: 'Приседания со штангой', sets: 4, reps: 10 },
    { name: 'Жим ногами', sets: 4, reps: 15 },
    { name: 'Румынская тяга', sets: 3, reps: 10 },
    { name: 'Выпады с гантелями', sets: 3, reps: 12 },
    { name: 'Скручивания', sets: 3, reps: 20 }
  ].each_with_index do |item, i|
    ex = Exercise.global.find_by(name: item[:name])
    lower.program_exercises.create!(exercise: ex, sets: item[:sets], reps: item[:reps], weight: 0, order_index: i) if ex
  end

  # 5. Кроссфит-круг
  crossfit = WorkoutProgram.create!(
    name: 'Кроссфит-круг',
    description: 'Круговая тренировка на всё тело. Высокий темп, много пота.',
    level: 'intermediate',
    is_template: true,
    user_id: nil
  )
  [
    { name: 'Бёрпи', sets: 3, reps: 15 },
    { name: 'Трастеры', sets: 3, reps: 12 },
    { name: 'Гиревой свинг', sets: 3, reps: 20 },
    { name: 'Скакалка', sets: 3, reps: 60 },
    { name: 'Планка', sets: 3, reps: 60 }
  ].each_with_index do |item, i|
    ex = Exercise.global.find_by(name: item[:name])
    crossfit.program_exercises.create!(exercise: ex, sets: item[:sets], reps: item[:reps], weight: 0, order_index: i) if ex
  end

  puts "Создано #{WorkoutProgram.templates.count} шаблонов программ"
end