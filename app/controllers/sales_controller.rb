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

  def show; end

  private

  def filter
    @sold_at = params[:sold_at] || Date.today
    @orders = @orders.left_outer_joins(stock_history: [stock: [:product]]).where(stocks: { branch_id: params[:branch_id] || 1 }).distinct
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