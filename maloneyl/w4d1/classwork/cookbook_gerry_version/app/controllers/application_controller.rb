class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :formatted_quantity
 

  def formatted_quantity quantity
    "#{quantity.quantity} #{quantity.measurement}"
  end
end
