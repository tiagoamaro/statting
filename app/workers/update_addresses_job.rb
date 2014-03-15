class UpdateAddressesJob
  def self.call_workers
    Address.all.each do |btc_address|
      UpdateAddressWorker.delay.perform(btc_address.id)
    end
  end
end