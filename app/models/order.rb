class Order < ApplicationRecord
  belongs_to :stock_history
  validates :sold_at, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end