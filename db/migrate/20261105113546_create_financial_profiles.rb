class CreateFinancialProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_profiles do |t|
      t.decimal :monthly_income
      t.decimal :monthly_expenses
      t.decimal :savings_goal
      t.string :risk_level
      t.string :main_goal
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
