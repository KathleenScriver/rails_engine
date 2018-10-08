require "rails_helper"

describe "Items API" do
  it 'should return all items' do
    items = create_list(:item, 15)

    get '/api/v1/items.json'

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result.count).to eq(15)
  end

  it 'should return one item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}.json"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(item.id)
  end

  it 'should find item by id' do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result["id"]).to eq(item.id)
    expect(result["name"]).to eq(item.name)
  end
end
