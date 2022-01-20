module ToastHelper
  def flash_color(key)
    case key
    when "success", "alert"
      "bg-success"
    when "danger", "error"
      "bg-danger"
    when "info", "notice"
      "bg-info"
    when "warning"
      "bg-warning"
    else
      "bg-danger"
    end
  end
end
