class BranchProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @branches = Branch.all.load_async
  end

  def products
    @branch_products = BranchProduct.where(branch_id: params[:branch_id])
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @branch_products = @branch_products.left_outer_joins(:product).where('products.name ILIKE :keyword', keyword: keyword)
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @branch_product.update(branch_product_params)
      flash[:warning] = "แก้ไขข้อมูลเรียบร้อยแล้ว"

      respond_to do |format|
        format.turbo_stream
      end
    else
      flash[:danger] = @ot_pre_request.errors.full_messages.to_sentence

      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def check
  end

  private

  def branch_product_params
    params.require(:branch_product)
          .permit(
            :qty
          )
  end
end