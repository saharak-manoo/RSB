class StocksController < ApplicationController
  load_and_authorize_resource

  def index
    @branches = Branch.all.load_async
  end

  def products
    @stocks = Stock.where(branch_id: params[:branch_id])
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @stocks = @stocks.left_outer_joins(:product).where('products.name ILIKE :keyword', keyword: keyword)
    end

    respond_to do |format|
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