class CoinshiftController < ApplicationController
  require 'open-uri'
  require 'json'

  COINSHIFT_URL = 'http://coinshift.com'
  MONTH_PERFORMANCE_URL = "#{COINSHIFT_URL}/graph/api/v1/performance/30d"
  ADDRESS_URL = 'http://coinshift.com/api/stats/address/:payout_address'

  def month_performance
    json = JSON.parse(open(MONTH_PERFORMANCE_URL).read)

    btc_per_mh = reverse_datapoints json[0]['datapoints']
    hashrate = reverse_datapoints json[1]['datapoints']
    reject = reverse_datapoints json[2]['datapoints']

    btc_per_mh = convert_to_javascript_time btc_per_mh
    hashrate = convert_to_javascript_time hashrate
    reject = convert_to_javascript_time reject

    json = Hash[
      json[0]['target'], btc_per_mh,
      json[1]['target'], hashrate,
      json[2]['target'], reject
    ]

    respond_to do |format|
      format.json { render json: json }
    end
  end

  private

  def reverse_datapoints(datapoint)
    datapoint.map { |k, v| [v, k] }
  end

  def convert_to_javascript_time(array)
    array.map { |timestamp, value| [timestamp*1000, value] }
  end
end
