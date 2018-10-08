class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(search_params)
  end

  private
  def search_params
    params.permit(:id, :name)
  end
end
