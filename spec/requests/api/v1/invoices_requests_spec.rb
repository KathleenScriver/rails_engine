require "rails_helper"

describe "Invoice API" do
  it 'gets all invoices' do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(5)
  end
end
