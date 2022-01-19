class CreateBranchProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :branch_products do |t|
      t.references  :branch, index: true, null: false, foreign_key: { to_table: :branches }
      t.references  :product, index: true, null: false, foreign_key: { to_table: :products }
      t.integer     :qty, null: false, default: 0

      t.timestamps
    end
  end
end
