class CoinshiftController < ApplicationController
  def month_performance
    respond_to do |format|
      format.json { render json: Coinshift.month_performance }
    end
  end
end
