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
end
