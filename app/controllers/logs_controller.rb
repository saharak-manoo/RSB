class LogsController < ApplicationController
  def index
    @stock_histories = StockHistory.all
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @stock_histories = @stock_histories.left_outer_joins(:user, :product, :branch, :orders)
                                         .where("CONCAT_WS(' ', users.first_name, users.last_name) ILIKE :keyword or
                                                 products.name ILIKE :keyword or
                                                 branches.name ILIKE :keyword or
                                                 orders.price::TEXT ILIKE :keyword", keyword: keyword).distinct
    end
    @stock_histories = @stock_histories.order(updated_at: :desc).page(params[:page] || 1).per(5)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end