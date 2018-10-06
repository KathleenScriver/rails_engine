class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date]), serializer: MerchantRevenueSerializer
  end

  def show
    render json: Merchant.single_revenue(params[:id]), serializer: SingleMerchantRevenueSerializer
  end
end
