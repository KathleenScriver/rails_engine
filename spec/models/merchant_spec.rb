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
      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id, created_at: "2015-04-15")
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id)
      @invoice_3 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id, created_at: "2015-04-15")
      @invoice_4 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id)
      @invoice_5 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id, created_at: "2015-04-15")
      @invoice_6 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id)
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_1.id)
      @item_3 = create(:item, merchant_id: @merchant_1.id)
      @item_4 = create(:item, merchant_id: @merchant_1.id)
      @item_5 = create(:item, merchant_id: @merchant_2.id)
      @item_6 = create(:item, merchant_id: @merchant_2.id)
      @item_7 = create(:item, merchant_id: @merchant_3.id)
      @item_8 = create(:item, merchant_id: @merchant_3.id)
      @item_9 = create(:item, merchant_id: @merchant_3.id)
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
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "pending")
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id)
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id)
    end

    context '.most_revenue' do
      it 'should return top x merchants with highest revenue' do
        expect(Merchant.most_revenue(2)). to eq([@merchant_1, @merchant_3])
        expect(Merchant.most_revenue(1)). to eq([@merchant_1])
      end
    end

    context '.most_items' do
      it 'should return top x merchants with most items sold' do
        expect(Merchant.most_items(2)). to eq([@merchant_1, @merchant_2])
        expect(Merchant.most_items(1)). to eq([@merchant_1])
      end
    end

    context '.revenue_by_date' do
      it 'should return total revenue for all mechants on given date' do
        expect(Merchant.revenue_by_date("2015-04-15")).to eq(314700.0)
      end
    end
  end
end
