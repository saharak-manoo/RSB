class ApplicationController < ActionController::Base
  def render_flash
    render turbo_stream: turbo_stream.update("showToast", partial: "partials/toast")
  end
end
