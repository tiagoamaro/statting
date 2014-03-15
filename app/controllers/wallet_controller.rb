class WalletController < ApplicationController
  def address
    btc_address = params[:btc_address]

    if Bitcoin::valid_address?(btc_address)
      @btc_address = Address.find_or_create_by(address: btc_address)
    else
      flash[:warning] = 'Invalid BTC Address'
      redirect_to root_path
    end
  end
end
