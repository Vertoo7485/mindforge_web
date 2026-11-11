achievements = [
  { title: 'Первые шаги', description: 'Выполните первую задачу', icon: '🎯', condition_type: 'tasks_completed', condition_value: 1 },
  { title: 'Транжира', description: 'Добавьте первый расход', icon: '💸', condition_type: 'expenses_count', condition_value: 1 },
  { title: 'Капиталист', description: 'Добавьте первый доход', icon: '💰', condition_type: 'incomes_count', condition_value: 1 },
  { title: 'Пламенная серия', description: 'Отметьте привычку 7 дней подряд', icon: '🔥', condition_type: 'habit_streak', condition_value: 7 },
  { title: 'Продуктивный день', description: 'Выполните 5 задач за день', icon: '⚔️', condition_type: 'tasks_per_day', condition_value: 5 },
  { title: 'Путь воина', description: 'Достигните 2 уровня', icon: '🏆', condition_type: 'level', condition_value: 2 },
  { title: 'Мастер задач', description: 'Выполните 50 задач', icon: '✅', condition_type: 'tasks_completed', condition_value: 50 },
  { title: 'Король привычек', description: 'Отметьте 100 привычек', icon: '👑', condition_type: 'habits_completed', condition_value: 100 },
  { title: 'Накопитель', description: 'Создайте цель накопления', icon: '🎯', condition_type: 'savings_goals_count', condition_value: 1 },
  { title: 'Борец с долгами', description: 'Погасите долг полностью', icon: '🛡️', condition_type: 'debts_completed', condition_value: 1 },
  { title: 'Планировщик', description: 'Создайте 10 задач', icon: '📋', condition_type: 'tasks_created', condition_value: 10 },
  { title: 'Аналитик', description: 'Добавьте 20 транзакций', icon: '📊', condition_type: 'transactions_count', condition_value: 20 },
  { title: 'Стрелок', description: 'Выполните задачу с высоким приоритетом', icon: '🎪', condition_type: 'high_priority_tasks', condition_value: 1 },
  { title: 'Рутинный герой', description: 'Создайте привычку', icon: '🔄', condition_type: 'habits_created', condition_value: 1 },
  { title: 'Бюджетный гуру', description: 'Установите бюджет', icon: '💼', condition_type: 'budgets_count', condition_value: 1 },
  { title: 'Финансовый маг', description: 'Достигните 5 уровня', icon: '🧙', condition_type: 'level', condition_value: 5 }
]

achievements.each do |a|
  Achievement.find_or_create_by(title: a[:title]) do |ach|
    ach.assign_attributes(a)
  end
end

puts "Создано #{Achievement.count} достижений"