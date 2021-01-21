class Order < ApplicationRecord
require 'rest-client'

  has_one :payment, dependent: :destroy
  has_one :coupon
  has_many :order_products
  has_many :products, :through => :order_products, dependent: :destroy
  after_update :calcprice

  def setprice
    self.price = calcprice
    save!
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

  def paid
    response = RestClient.post ENV['API_PAYMENT'],
    { userId: ENV['PAYMENT_USER'], pageCode: ENV['PAYMENT_CODE'],
      sum: price, description: productlist, paymentNum: 1, maxPaymentNum: 1, fullName: name, phone: phone,
      successUrl: "#{ENV['API_URL']}/paid?id=#{id}", cancelUrl: "#{ENV['API_URL']}/cart?id=#{id}?takeaway=#{takeaway}" }
    result = JSON.parse(response)
    puts result['body']
    puts "#{ENV['PAYMENT_USER']} #{ENV['PAYMENT_CODE']} #{ENV['API_PAYMENT']} "
    binding.pry
    return { data: 'error', status: 500 } unless result['status'] == 1
    Payment.create(order: self, processId: result['data']['processId'],
                   processToken: result['data']['processToken'])
    self.url = result['data']['url']
    save
    { data: 'success', status: 200 }
  end

  def approve
    response = RestClient.post ENV['API_APPROVEPAY'],
    { pageCode: ENV['PAYMENT_CODE'],
      transactionToken: payment.transactionToken, transactionId: payment.transactionId }
    result = JSON.parse(response)
    return { data: 'error', status: 500 } unless result['status'] == 1

    self.status = true
    save
    { data: 'success', status: 200 }
  end
end
