class SalesController < ApplicationController
  load_and_authorize_resource :order, parent: false

  def index
    @branches = Branch.all.load_async
    filter

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @stock = Stock.find_by_product_id(params[:product_id])
    @date = params[:sold_at].to_date
    @orders = @orders.where(sold_at: params[:sold_at].to_date).left_outer_joins(stock_history: [:stock]).where(stocks: { product_id: @stock.product_id }).distinct
    @sales = Sale.calculate(@orders, false)

    @sales = Kaminari.paginate_array(@sales).page(params[:page] || 1).per(5)
  end

  private

  def filter
    date_now = Time.now
    @start_date = params[:start_date] || date_now.beginning_of_month.to_date
    @end_date = params[:end_date] || date_now.to_date
    @orders = @orders.where(sold_at: @start_date..@end_date).left_outer_joins(stock_history: [stock: [:product]]).where(stocks: { branch_id: params[:branch_id] || 1 }).distinct
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @orders = @orders.where('products.name ILIKE :keyword', keyword: keyword)
    end

    @sales = Sale.calculate(@orders)
    if params[:sort_key].present? && params[:order].present?
      @sales = @sales.sort_by { |s| s[params[:sort_key].to_sym] }
      @sales = @sales.reverse if params[:order] == "desc"
    end

    @sales = Kaminari.paginate_array(@sales).page(params[:page] || 1).per(params[:limit] || 5)
  end
end