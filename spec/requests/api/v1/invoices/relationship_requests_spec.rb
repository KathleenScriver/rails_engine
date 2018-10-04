require "rails_helper"

describe "Invoices API Relationship Endpoints" do

  it 'should return all associated transactions' do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 12, invoice_id: invoice.id)
    transaction_99 = create(:transaction)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    resulting_transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_transactions.count).to eq(12)
    expect(resulting_transactions.pluck(:id).include?(transaction_99.id)).to be_falsey
  end
end
