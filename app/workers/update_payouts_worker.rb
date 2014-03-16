class UpdatePayoutsWorker
  def self.perform(address_id)
    btc_address = Address.find(address_id)
    btc_address.payouts.destroy_all

    json = Coinshift.address_data(btc_address.address)
    unless json.empty?
      json['payouts'].each do |payout|
        Payout.create(timestamp: payout['timestamp'], value: payout['value'], tx: payout['tx'], address: btc_address)
      end
    end
  end
end
