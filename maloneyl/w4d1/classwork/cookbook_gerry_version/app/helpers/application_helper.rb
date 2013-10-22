module ApplicationHelper
  def total_cost recipe
    prices = recipe.quantities.map { |quantity| quantity.price }
    total_price = prices.inject{ |sum, item | sum += item}.round(2)
    total_price_in_pounds = (total_price/1.62).round(2)
    "$#{total_price} or £#{total_price_in_pounds}"
  end
end
