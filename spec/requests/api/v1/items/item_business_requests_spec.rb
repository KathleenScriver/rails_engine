require "rails_helper"

descirbe "Item API Business Intelligence" do
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
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id)
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "pending")
    @transaction_5 = create(:transaction, invoice_id: @invoice_5.id)
    @transaction_6 = create(:transaction, invoice_id: @invoice_6.id)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)
    @item_7 = create(:item, merchant_id: @merchant_3.id)
    @item_8 = create(:item, merchant_id: @merchant_3.id)
    @item_9 = create(:item, merchant_id: @merchant_3.id)
    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, quantity: 1, unit_price: 2500, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, quantity: 5, unit_price: 50000, item_id: @item_1.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, quantity: 1, unit_price: 7000, item_id: @item_2.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, quantity: 1, unit_price: 5500, item_id: @item_2.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_3.id, quantity: 2, unit_price: 20000, item_id: @item_3.id)
    @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_3.id, quantity: 1, unit_price: 2200, item_id: @item_3.id)
    @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_4.id, quantity: 3, unit_price: 9200, item_id: @item_4.id)
    @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_5.id, quantity: 1, unit_price: 20000, item_id: @item_4.id)
    @invoice_item_9 = create(:invoice_item, invoice_id: @invoice_6.id, quantity: 2, unit_price: 8800, item_id: @item_4.id)
    @invoice_item_10 = create(:invoice_item, invoice_id: @invoice_6.id, quantity: 1, unit_price: 29200, item_id: @item_5.id)
  end
  it 'should return top x items by revenue' do
    get '/api/v1/items/most_revenue?quantity=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(@item_4.id)
  end
end
