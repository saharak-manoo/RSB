class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def new; end

  def create
  end
end