class LogsController < ApplicationController
  def index
    @stock_histories = StockHistory.all
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @stock_histories = @stock_histories.left_outer_joins(:product).where('products.name ILIKE :keyword', keyword: keyword)
    end
    @stock_histories = @stock_histories.order(updated_at: :desc).page(params[:page] || 1).per(5)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end