require "rails_helper"

describe "Customer API" do
  it 'sends list of all customers' do
    create_list(:customer, 4)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(4)
  end

  it 'gets single customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it 'finds favorite merchant' do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_4 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_5 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)
    invoice_6 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
    transaction_1 = invoice_1.transactions.create(result: "success")
    transaction_2 = invoice_1.transactions.create(result: "success")
    transaction_3 = invoice_2.transactions.create(result: "success")
    transaction_4 = invoice_3.transactions.create(result: "success")
    transaction_5 = invoice_4.transactions.create(result: "success")
    transaction_6 = invoice_5.transactions.create(result: "success")
    transaction_7 = invoice_6.transactions.create(result: "success")

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["name"]).to eq(merchant_3.name)
  end

  it 'can return a random resource' do
    customers = create_list(:customer, 10)

    get '/api/v1/customers/random.json'

    random_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.pluck(:first_name).include?(random_customer["first_name"])).to be_truthy
  end
end
