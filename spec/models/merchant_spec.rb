require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:customers), through: :invoices }
  end

  describe 'class methods' do
    before(:each) do
      @customer = create(:customer)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id)
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id)
      @invoice_3 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id)
      @invoice_4 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id)
      @invoice_5 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id)
      @invoice_6 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id)
      @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, quantity: 1, unit_price: 2500)
      @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, quantity: 5, unit_price: 50000)
      @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, quantity: 1, unit_price: 7000)
      @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, quantity: 1, unit_price: 5500)
      @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_3.id, quantity: 2, unit_price: 20000)
      @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_3.id, quantity: 1, unit_price: 2200)
      @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_4.id, quantity: 3, unit_price: 9200)
      @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_5.id, quantity: 1, unit_price: 20000)
      @invoice_item_9 = create(:invoice_item, invoice_id: @invoice_6.id, quantity: 2, unit_price: 8800)
      @invoice_item_10 = create(:invoice_item, invoice_id: @invoice_6.id, quantity: 1, unit_price: 29200)
    end

    context '.most_revenue' do
      it 'should return top x merchants with highest revenue' do
        expect(Merchant.most_revenue(2)). to eq([@merchant_1, @merchant_2])
        expect(Merchant.most_revenue(1)). to eq([@merchant_2])
      end
    end
  end
end
