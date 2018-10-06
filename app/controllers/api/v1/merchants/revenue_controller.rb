class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date]), serializer: MerchantRevenueSerializer
  end

  def show

  end 
end
