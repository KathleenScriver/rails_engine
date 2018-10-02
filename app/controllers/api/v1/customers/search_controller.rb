class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: Customer.find_by(search_params)
  end

  private
    def search_params
      params.permit(:first_name, :last_name)
    end
end
