module DogWalkingPrice
  module_function

  INITIAL_PRICE = { half_hour: 25, hour: 35 }
  ADDITIONAL_PRICE = { half_hour: 15, hour: 20 }

  def calculate(duration, pets_quantity)
    @duration = duration.to_sym
    @pets_quantity = pets_quantity
    return 0 if @pets_quantity.zero?

    get_price
  end

  def get_price
    initial_price + additional_price
  end

  def initial_price
    INITIAL_PRICE[@duration]
  end

  def additional_price
    ADDITIONAL_PRICE[@duration] * (@pets_quantity - 1)
  end

  private_class_method :get_price, :initial_price, :additional_price
end
