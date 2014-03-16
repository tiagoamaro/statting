class UpdatePayoutsJob
  def self.call_workers
    Address.all.each do |btc_address|
      UpdatePayoutsWorker.delay.perform(btc_address.id)
    end
  end
end