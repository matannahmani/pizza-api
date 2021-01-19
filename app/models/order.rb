class Order < ApplicationRecord
  # geocoded_by :address
  # after_validation :geocode
  after_create :setprice
  has_one :coupon
  has_many :order_products
  has_many :products, :through => :order_products

  def setprice
    self.price = calcprice
    save
  end

  def productlist
    order_products.map { |p| [p.product.name,p.amount,p.size]}
  end

  def calcprice
    price = 0
    discount = 0
    !coupon.nil? ? discount = coupon.discount : discount = 0
    order_products.each do |product|
      jprice = product.product.jprice * product.product.size.find_index(product.size)
      price += (product.product.price + jprice) * product.amount
    end
    price * ((100 - discount) / 100.00)
  end
end
