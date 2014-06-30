class StoreController < ApplicationController
include CurrentCart
  before_action :set_cart

  def index
    if session[:count].nil?
      session[:count] = 1
    else
      session[:count] += 1
    end
    @products = Product.order(:title)
  end
end
