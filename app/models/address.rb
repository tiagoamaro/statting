class Address < ActiveRecord::Base
  has_many :balances
  has_many :hash_rates
  has_many :payouts

  # [[timestamp, value], [timestamp, value], ...]
  def to_stockchart
    exchanged = balances.map { |b| [b.created_at.to_i*1000, b.exchanged] }
    unexchanged = balances.map { |b| [b.created_at.to_i*1000, b.unexchanged] }
    hashrates = hash_rates.map { |h| [h.created_at.to_i*1000, h.hash_rate] }
    rejectrates = hash_rates.map { |h| [h.created_at.to_i*1000, h.reject_rate] }

    Hash[
      'last_updated', DateTime.now.utc.to_s(:db),
      'exchanged', exchanged,
      'unexchanged', unexchanged,
      'hashrates', hashrates,
      'rejectrates', rejectrates
    ]
  end
end
