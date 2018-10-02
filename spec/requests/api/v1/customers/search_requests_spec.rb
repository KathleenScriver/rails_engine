require "rails_helper"

describe "Customer Search API" do

  it 'finds single record by first name' do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name", params: {first_name: "#{first_name}" }

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["first_name"]).to eq(first_name)
  end
end
