class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(search_params)
  end

  def index
    if params[:unit_price]
      render json: Item.where(unit_price: params[:unit_price].gsub(/\D/,"")) if params[:unit_price]
    else
      render json: Item.where(search_params)
    end
  end

  private
  def search_params
    params.permit(:id,
                  :name,
                  :description,
                  :created_at,
                  :updated_at,
                  :merchant_id)

  end
end
