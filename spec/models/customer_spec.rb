require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'instance methods' do
    context '#favorite_merchant' do
      it 'should return merchant this customer has most successful transactions with' do
        customer = create(:customer)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
        invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
        invoice_4 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
        invoice_5 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
        invoice_6 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
        transaction_1 = invoice_1.transactions.create(result: "success")
        transaction_2 = invoice_1.transactions.create(result: "success")
        transaction_3 = invoice_2.transactions.create(result: "success")
        transaction_4 = invoice_3.transactions.create(result: "success")
        transaction_5 = invoice_4.transactions.create(result: "success")
        transaction_6 = invoice_5.transactions.create(result: "success")
        transaction_7 = invoice_6.transactions.create(result: "success")

        expect(Customer.favorite_merchant(customer.id)).to eq(merchant_3)
      end
    end
  end
end
