class UpdateAddressWorker
  include Sidekiq::Worker

  # TODO: If we have many addresses, this will not work well
  def perform
    Address.all.each do |btc_address|
      json = Coinshift.address_data(btc_address.address)

      btc_address.payouts.destroy_all

      Balance.create(exchanged: json['exchanged_balance'], unexchanged: json['unexchanged_balance'], address: btc_address)
      HashRate.create(hash_rate: json['hashrate'], reject_rate: json['rejectrate'], address: btc_address)
      json['payouts'].each do |payout|
        Payout.create(timestamp: payout['timestamp'], value: payout['value'], tx: payout['tx'], address: btc_address)
      end
    end
  end
end