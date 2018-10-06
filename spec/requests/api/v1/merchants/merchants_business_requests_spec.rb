require "rails_helper"

describe "Merchant Business API" do
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

  it 'should return top merchants by revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants.first["name"]).to eq(@merchant_1.name)
  end

  it 'should return top merchants by number of items sold' do
    get '/api/v1/merchants/most_items?quantity=2'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants.first["name"]).to eq(@merchant_1.name)
    expect(merchants.second["name"]).to eq(@merchant_2.name)
  end

  it 'should return total revenue for all merchants on given date' do
    get '/api/v1/merchants/revenue?date=2015-04-15'

    total_revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(total_revenue).to eq({"total_revenue"=>"3147.00"})
  end
end
