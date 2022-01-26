class StocksController < ApplicationController
  load_and_authorize_resource

  def index
    @branches = Branch.all.load_async
    @stocks = Stock.where(branch_id: params[:branch_id] || 1).order(updated_at: :desc).limit(2)
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @stocks = @stocks.left_outer_joins(:product).where('products.name ILIKE :keyword', keyword: keyword)
    end
    @page_stocks = @stocks.page(params[:page] || 1).per(2)

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

  private

  def stock_params
    params.require(:stock)
          .permit(
            :qty
          )
  end
end