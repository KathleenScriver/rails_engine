require "rails_helper"

describe "Invoice Search API" do

  it 'should find single invoice by id' do
    id = create(:invoice).id

    get '/api/v1/invoices/find?id', params: {id: id}

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(id)
  end
end
