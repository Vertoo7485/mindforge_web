class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.decimal :amount
      t.string :category
      t.date :date
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
