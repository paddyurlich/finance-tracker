class StocksController < ApplicationController

#note: the find_by_ticker and new_from_ticker methods are found in the stock.rb model. 

  def search
    if params[:stock]
      @stock = Stock.find_by_ticker(params[:stock])
      @stock ||= Stock.new_from_lookup(params[:stock])
    end
    
    if @stock
      #render json: @stock
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end
  
end