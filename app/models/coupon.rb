class Coupon < ApplicationRecord
  validates :code, uniqueness: true
  validates :discount, presence: true
  validates :status, inclusion: { in: [true,false] }
end
