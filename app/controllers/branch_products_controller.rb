class BranchProductsController < ApplicationController
  def index
    @branches = Branch.all.load_async
  end

  def products
    @branch_products = BranchProduct.where(branch_id: params[:branch_id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
  end
end