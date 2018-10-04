class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.revenue_by_date(date)
  end
end
