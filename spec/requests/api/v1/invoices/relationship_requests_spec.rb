require "rails_helper"

describe "Invoices API Relationship Endpoints" do

  it 'should return all associated transactions' do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 12, invoice_id: invoice.id)
    transaction_99 = create(:transaction)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results.count).to eq(12)
    expect(results.pluck(:id).include?(transaction_99.id)).to be_falsey
  end

  it 'should return all associated invoice items' do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 8, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results.count).to eq(8)
  end

  it 'should return all associated items' do
    invoice = create(:invoice)
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    item_4 = create(:item)
    item_5 = create(:item)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_4.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_5.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result.count).to eq(4)
  end

  it 'should return associated customer' do
    invoice = create(:invoice)
    customer = invoice.customer

    get "/api/v1/invoices/#{invoice.id}/customer"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(customer.id)
  end

  it 'should return associated merchant' do
    invoice = create(:invoice)
    merchant = invoice.merchant

    get "/api/v1/invoices/#{invoice.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(merchant.id)
  end
end
