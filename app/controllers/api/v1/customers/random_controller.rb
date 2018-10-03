class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: Customer.find(rand(1..(Customer.count)))
  end
end
