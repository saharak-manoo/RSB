class CreateStockHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_histories do |t|
      t.references  :user, index: true, null: false, foreign_key: { to_table: :users }
      t.references  :stock, index: true, null: false, foreign_key: { to_table: :stocks }
      t.references  :target_branch, index: true, null: true, foreign_key: { to_table: :branches }
      t.integer     :status, null: false, default: 0
      t.integer     :qty, null: false, default: 0

      t.timestamps
    end
  end
end
