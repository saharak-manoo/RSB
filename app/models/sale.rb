class Sale
  def self.calculate(orders)
    @sales = []
    orders.each do |order|
      stock_history = order.stock_history
      product = stock_history.stock.product

      sale = @sales.find { |d| d[:product_id] == product.id && d[:sold_at] == order.sold_at }
      if sale.present?
        sale[:qty] += 1
        sale[:price] += order.price
      else
        @sales << {
          product_id: product.id,
          product_name: product.name,
          qty: 1,
          sold_at: order.sold_at,
          price: order.price,
          order: order
        }
      end
    end

    return @sales
  end
end