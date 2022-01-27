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

  private

  def filter
    @sold_at = params[:sold_at] || Date.today
    @orders = @orders.where(sold_at: @sold_at.to_date).left_outer_joins(stock_history: [stock: [:product]]).where(stocks: { branch_id: params[:branch_id] || 1 }).distinct
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @orders = @orders.where('products.name ILIKE :keyword', keyword: keyword)
    end

    if params[:sort_key].present? && params[:order].present?
      case params[:sort_key]
      when "product"
        @orders = @orders.order("products.name #{params[:order]}")
      when "sold_at"
        @orders = @orders.order("orders.sold_at #{params[:order]}")
      when "price"
        @orders = @orders.order("orders.price #{params[:order]}")
      end
    end

    @orders = @orders.page(params[:page] || 1).per(params[:limit] || 5)
  end
end