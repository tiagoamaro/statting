class UpdateAddressWorker
  def self.perform(address_id)
    btc_address = Address.find(address_id)

    json = Coinshift.address_data(btc_address.address)
    unless json.empty?
      Balance.create(exchanged: json['exchanged_balance'], unexchanged: json['unexchanged_balance'], address: btc_address)
      HashRate.create(hash_rate: json['hashrate'], reject_rate: json['rejectrate'], address: btc_address)
    end
  end
end

