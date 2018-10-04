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
end
