module ApplicationHelper
  def precision(val)
    number_with_precision(val || 0, precision: 2, delimiter: ',')
  end
end
