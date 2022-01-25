class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references  :stock_history, index: true, null: false, foreign_key: { to_table: :stock_histories }
      t.date        :sold_at, null: false
      t.decimal     :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
