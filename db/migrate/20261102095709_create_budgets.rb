class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.string :category
      t.decimal :amount
      t.string :period
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
