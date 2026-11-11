class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.integer :level
      t.integer :xp
      t.integer :xp_to_next_level
      t.integer :coins
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
