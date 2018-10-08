class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(search_params)
  end

  private
  def search_params
    params.permit(:id, :name, :description, :created_at, :updated_at, :merchant_id, :unit_price)
  end
end
