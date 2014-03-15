class Coinshift
  require 'open-uri'
  require 'json'

  COINSHIFT_URL = 'http://coinshift.com'
  MONTH_PERFORMANCE_URL = "#{COINSHIFT_URL}/graph/api/v1/performance/30d"
  ADDRESS_URL = 'http://coinshift.com/api/stats/address/:address'

  def self.month_performance
    json = Rails.cache.fetch(['month_performance'], expires_in: 10.minutes) do
      JSON.parse(open(MONTH_PERFORMANCE_URL).read)
    end

    transform_month_performance(json) unless json.empty?
  end

  def self.address_data(address)
    json = Rails.cache.fetch(['address', address], expires_in: 10.minutes) do
      address_url = ADDRESS_URL.gsub(':address', address)
      JSON.parse(open(address_url).read)
    end
  rescue
    {} # Address was not found, so we return an empty hash
  end

  private

  def self.transform_month_performance(json)
    btc_per_mh = reverse_datapoints json[0]['datapoints']
    hashrate = reverse_datapoints json[1]['datapoints']
    reject = reverse_datapoints json[2]['datapoints']

    btc_per_mh = convert_to_javascript_time btc_per_mh
    hashrate = convert_to_javascript_time hashrate
    reject = convert_to_javascript_time reject

    Hash[
      json[0]['target'], btc_per_mh,
      json[1]['target'], hashrate,
      json[2]['target'], reject
    ]
  end

  def self.reverse_datapoints(datapoint)
    datapoint.map { |k, v| [v, k] }
  end

  def self.convert_to_javascript_time(array)
    array.map { |timestamp, value| [timestamp*1000, value] }
  end
end
