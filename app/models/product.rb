class Product < ApplicationRecord
  has_one_attached :photo
  before_validation :pizzasize
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :status, inclusion: { in: [true,false] }
  belongs_to :order_product, optional: :true
  has_many :products, :through => :order_products

  def photo_url
    photo.attached? ? photo.service_url : nil
  end

  private

  def pizzasize
    if size.blank?
      errors.add(:size, "size is blank/invalid")
    elsif size.detect { |s| !(%w(M L XL XXL 55CM).include? s) }
      errors.add(:size, "size is invalid")
    end
  end
end
