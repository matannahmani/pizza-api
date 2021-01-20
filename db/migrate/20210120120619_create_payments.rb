class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :transactionId
      t.string :transactionToken
      t.integer :transactionTypeId
      t.integer :paymentType
      t.float :sum
      t.float :firstPaymentSum
      t.float :periodicalPaymentSum
      t.integer :paymentsNum
      t.integer :allPaymentsNum
      t.string :paymentDate
      t.string :asmachta
      t.string :description
      t.string :fullName
      t.string :payerPhone
      t.string :payerEmail
      t.string :cardSuffix
      t.string :cardType
      t.integer :cardTypeCode
      t.string :cardBrand
      t.integer :cardBrandCode
      t.string :cardExp
      t.integer :processId
      t.string :processToken
      t.string :customFields, array: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
