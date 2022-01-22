class CreateStock < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references  :branch_product, index: true, null: false, foreign_key: { to_table: :branch_products }
      t.integer     :status, null: false, default: 0

      t.timestamps
    end
  end
end
