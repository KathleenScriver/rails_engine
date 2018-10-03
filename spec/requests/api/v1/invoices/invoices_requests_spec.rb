require "rails_helper"

describe "Invoice API" do
  it 'gets all invoices' do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(5)
  end

  it 'gets one invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(invoice.id)
  end
end
