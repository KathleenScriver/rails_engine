require "rails_helper"

describe "Customer API" do
  it 'sends list of all customers' do
    create_list(:customer, 4)

    get '/api/v1/customers'

    expect(response).to be_successful
    expect(response.body.count).to eq(4)
  end
end
