class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: Invoice.find(rand(1..(Invoice.count)))
  end
end
