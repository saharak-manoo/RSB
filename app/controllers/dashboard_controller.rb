class DashboardController < ApplicationController
  def index
    @annual_sales = Order.sum(:price)
    @sales_past_3_month = Order.where(sold_at: 3.month.ago.to_date..Time.now.to_date).sum(:price)
    @sales_1_month = Order.where(sold_at: Time.now.beginning_of_month.to_date..Time.now.to_date).sum(:price)
  end
end