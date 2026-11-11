class MakeUserOptionalForTemplates < ActiveRecord::Migration[7.1]
  def change
    change_column_null :exercises, :user_id, true
    change_column_null :workout_programs, :user_id, true
    add_column :workout_programs, :is_template, :boolean, default: false
    add_column :workout_programs, :level, :string, default: 'beginner'
  end
end