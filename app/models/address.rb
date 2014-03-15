class Address < ActiveRecord::Base
  has_many :balances
  has_many :hash_rates
  has_many :payouts
end
