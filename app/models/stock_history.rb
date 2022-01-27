class StockHistory < ApplicationRecord
  extend SimplestStatus
  statuses :import, :export, :change_branch
  belongs_to :stock
  has_one :product, through: :stock
  has_one :branch, through: :stock
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :stock_id, :status, :qty, presence: true
  validates :target_branch_id, presence: true, if: :not_status_export
  validates :qty, numericality: { greater_than: 0 }
  after_create :update_stock
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

  def target_branch
    Branch.find_by_id(target_branch_id)
  end

  def status_color
    if import?
      "success"
    elsif export?
      "danger"
    else change_branch
      "warning"
    end
  end
end