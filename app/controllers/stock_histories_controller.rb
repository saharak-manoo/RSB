class StockHistoriesController < ApplicationController
  load_and_authorize_resource

  def new
    @stock = Stock.find_by_id(params[:stock_id])
    @stock_history_statuses = StockHistory.statuses.map.with_index { |key, index| [I18n.t(key.to_s), index] }
    @branches = Branch.where.not(id: @stock.branch_id).load_async
    @stock_history.orders.build
  end

  def create
    if @stock_history.save
      flash[:warning] = "บันทึกค่าเรียบร้อยแล้ว"

      redirect_to stocks_path
    else
      flash[:danger] = @stock_history.errors.full_messages.to_sentence

      redirect_to new_stock_stock_history_path
    end
  end

  def update
    if @stock_history.update(stock_history_params)
      flash[:warning] = "แก้ไขข้อมูลเรียบร้อยแล้ว"

      redirect_to stocks_path
    else
      flash[:danger] = @stock_history.errors.full_messages.to_sentence

      redirect_to edit_stock_stock_history_path(@stock_history)
    end
  end

  private

  def stock_history_params
    params.require(:stock_history)
          .permit(
            :status,
            :stock_id,
            :target_branch_id,
            :qty,
            orders_attributes: [:stock_history_id, :sold_at, :price, :_destroy]
          )
  end
end