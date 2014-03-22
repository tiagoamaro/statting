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
      'last_exchanged', balances.last.exchanged,
      'last_unexchanged', balances.last.unexchanged,
      'last_hash', hash_rates.last.hash_rate,
      'last_reject', hash_rates.last.reject_rate,
      'exchanged', exchanged,
      'unexchanged', unexchanged,
      'hashrates', hashrates,
      'rejectrates', rejectrates
    ]
  end
end
