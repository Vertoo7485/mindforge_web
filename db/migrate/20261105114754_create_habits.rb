class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.string :name
      t.string :frequency
      t.integer :target_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
