require 'clockwork'
require 'sidekiq'

Dir["app/workers/*"].each {|f| load f }

include Clockwork

# every(10.minutes, 'update.addresses') { UpdateAddressWorker.perform_async }
every(10.seconds, 'update.addresses') { UpdateAddressWorker.perform_async }
