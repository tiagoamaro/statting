require 'clockwork'
require './config/boot'
require './config/environment'

Dir["app/workers/*"].each {|f| load f }

include Clockwork

every(5.minutes, 'update.addresses') { UpdateAddressesJob.call_workers }
