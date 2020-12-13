class SetCouponStatusDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :coupons, :status, from: nil, to: false
  end
end
