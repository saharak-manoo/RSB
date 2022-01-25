class StockHistory < ApplicationRecord
  extend SimplestStatus
  statuses :import, :export, :change_branch
  validates :stock_id, :status, :qty, presence: true
  validates :target_branch_id, presence: true, if: :not_status_export
  validates :qty, numericality: { greater_than: 0 }
  after_create :update_stock
  belongs_to :stock
  has_many   :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, allow_destroy: true

  def not_status_export
    !export?
  end

  def update_stock
    if import?
      stock.qty += qty
    elsif change_branch? || export?
      stock.qty -= qty
    end

    stock.save
  end
end