class BranchProductsController < ApplicationController
  def index
    @branches = Branch.all.load_async

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end
end