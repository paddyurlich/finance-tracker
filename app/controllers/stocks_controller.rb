class StocksController < ApplicationController

  def search
    #debugger
    if params[:stock]
      @stock = Stock.find_by_ticker(params[:stock])  # find_by_ticker - looks in the Stock table
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