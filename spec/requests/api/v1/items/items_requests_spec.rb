require "rails_helper"

describe "Items API" do
  it 'should return all items' do
    items = create_list(:item, 15)

    get '/api/v1/items.json'

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result.count).to eq(15)   
  end
end
