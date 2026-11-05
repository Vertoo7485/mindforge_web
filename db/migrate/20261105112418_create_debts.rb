class CreateDebts < ActiveRecord::Migration[7.1]
  def change
    create_table :debts do |t|
      t.string :title
      t.decimal :total_amount
      t.decimal :paid_amount
      t.decimal :monthly_payment
      t.string :icon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
