class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  before_save :setprice

  def setprice
    order.setprice
  end
end
