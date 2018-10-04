require "rails_helper"

describe "Invoice Search API" do

  it 'should find single invoice by id' do
    id = create(:invoice).id

    get '/api/v1/invoices/find?id', params: {id: id}

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(id)
  end

  it 'should find single invoice by status' do
    invoice = create(:invoice)

    get '/api/v1/invoices/find?status', params: {status: invoice.status}

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(invoice.id)
  end

  it 'should find single invoice by customer_id' do
    other_invoice = create(:invoice)
    invoice = create(:invoice)
    merchant = invoice.merchant

    get "/api/v1/invoices/find?merchant_id=#{merchant.id}"

    resulting_invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_invoice["id"]).to eq(invoice.id)
  end

  it 'should find single invoice by customer_id' do
    other_invoice = create(:invoice)
    invoice = create(:invoice)
    customer = invoice.customer

    get "/api/v1/invoices/find?customer_id=#{customer.id}"

    resulting_invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_invoice["id"]).to eq(invoice.id)
  end

  it 'should find single invoice by created at' do
    invoice_1 = create(:invoice, created_at: "2012-03-27 14:54:09 UTC" )
    invoice_2 = create(:invoice, created_at: "2012-04-27 14:54:09 UTC" )
    invoice_3 = create(:invoice, created_at: "2012-03-27 12:54:09 UTC" )
    invoice_4 = create(:invoice, created_at: "2012-07-27 14:54:09 UTC" )

    get '/api/v1/invoices/find?created_at', params: {created_at: "2012-03-27 12:54:09 UTC"}

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_3.id)
  end

  it 'should find single invoice by updated at' do
    invoice_1 = create(:invoice, updated_at: "2012-03-27 14:54:09 UTC" )
    invoice_2 = create(:invoice, updated_at: "2012-04-27 14:54:09 UTC" )
    invoice_3 = create(:invoice, updated_at: "2012-03-27 12:54:09 UTC" )
    invoice_4 = create(:invoice, updated_at: "2012-07-27 14:54:09 UTC" )

    get '/api/v1/invoices/find?updated_at', params: {updated_at: "2012-04-27 14:54:09 UTC"}

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_2.id)
  end

  it 'should find all invoices with matching id' do
    invoices = create_list(:invoice, 8)

    get '/api/v1/invoices/find_all?id=5'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.first["id"]).to eq(5)
  end

  it 'should find all invoices with matching status' do
    invoices = create_list(:invoice, 7)
    invoice_8 = create(:invoice, status: "pending")
    invoices << invoice_8

    get '/api/v1/invoices/find_all?status=shipped'

    resulting_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_invoices.count).to eq(7)
  end

  it 'should find all invoices by merchant id' do
    invoices = create_list(:invoice, 5)
    merchant = invoices.first.merchant
    merchant.invoices << invoices[1]
    merchant.invoices << invoices[2]

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    resulting_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_invoices.count).to eq(3)
  end

  it 'should find all invoices by customer id' do
    invoices = create_list(:invoice, 5)
    customer = invoices.first.customer
    customer.invoices << invoices[1]
    customer.invoices << invoices[2]

    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

    resulting_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(resulting_invoices.count).to eq(3)
  end

  it 'should find all invoices by created at' do
    invoice_1 = create(:invoice, created_at: "2012-03-27 12:54:09 UTC" )
    invoice_2 = create(:invoice, created_at: "2012-04-27 14:54:09 UTC" )
    invoice_3 = create(:invoice, created_at: "2012-03-27 12:54:09 UTC" )
    invoice_4 = create(:invoice, created_at: "2012-07-27 14:54:09 UTC" )

    get '/api/v1/invoices/find_all?created_at', params: {created_at: "2012-03-27 12:54:09 UTC"}

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(2)
  end
end
