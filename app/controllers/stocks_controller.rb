class StocksController < ApplicationController
  load_and_authorize_resource

  def index
    @branches = Branch.all.load_async
    filter

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    if @stock.update(stock_params)
      flash[:warning] = "แก้ไขข้อมูลเรียบร้อยแล้ว"

      redirect_to stocks_path
    else
      flash[:danger] = @stock.errors.full_messages.to_sentence

      redirect_to check_stock_path(@stock)
    end
  end

  def logs
    @stock_histories = @stock.stock_histories
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

  private

  def filter
    @stocks = Stock.where(branch_id: params[:branch_id] || 1)
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @stocks = @stocks.left_outer_joins(:product).where('products.name ILIKE :keyword', keyword: keyword)
    end

    @stocks = @stocks.page(params[:page] || 1).per(params[:limit] || 5)
  end

  def stock_params
    params.require(:stock)
          .permit(
            :qty
          )
  end
end