class WalletController < ApplicationController
  def address
    @btc_address = params[:btc_address]
  end
end
