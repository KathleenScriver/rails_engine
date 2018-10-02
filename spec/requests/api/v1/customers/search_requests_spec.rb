require "rails_helper"

describe "Customer Search API" do

  it 'finds single record by first name' do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name", params: {first_name: "#{first_name}" }

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["first_name"]).to eq(first_name)
  end

  it 'finds single record by last name' do
    last_name = create(:customer).last_name

    get '/api/v1/customers/find?last_name', params: {last_name: "#{last_name}"}

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["last_name"]).to eq(last_name)
  end
end
