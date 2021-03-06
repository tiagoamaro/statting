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

  def address_data
    btc_address = Address.find_by address: params[:btc_address]

    json = Rails.cache.fetch(['address_data', btc_address.address], expires_in: 5.minutes) do
      btc_address.to_stockchart
    end

    respond_to do |format|
      format.json { render json: json }
    end
  end
end
