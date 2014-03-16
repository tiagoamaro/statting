app_path = File.expand_path(File.dirname(__FILE__))

require 'clockwork'
require "#{app_path}/config/boot.rb"
require "#{app_path}/config/environment.rb"

Dir["app/workers/*"].each {|f| load f }

include Clockwork

every(5.minutes, 'update.addresses') { UpdateAddressesJob.call_workers }
every(1.hours, 'update.payouts') { UpdatePayoutsJob.call_workers }
