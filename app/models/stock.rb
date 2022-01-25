class Stock < ApplicationRecord
  belongs_to :branch
  belongs_to :product
  has_many   :stock_histories, dependent: :destroy
  accepts_nested_attributes_for :stock_histories, allow_destroy: true
  validates :branch_id, :product_id, :qty, presence: true
  validates :qty, numericality: { greater_than: 0 }
end