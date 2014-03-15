class WalletController < ApplicationController
  def address
    @btc_address = params[:btc_address]

    unless Bitcoin::valid_address?(@btc_address)
      flash[:warning] = 'Invalid BTC Address'
      redirect_to root_path
    end
  end
end
