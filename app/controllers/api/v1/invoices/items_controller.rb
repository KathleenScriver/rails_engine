class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).all_items
  end
end
