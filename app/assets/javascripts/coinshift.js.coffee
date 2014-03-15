# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.getJSON "/coinshift/month_performance", (data) ->
    btc_per_mh = data.btc_per_mh_24h
    hashrate = data.hashrate
    rejectrate = data.rejectrate

    # Create the chart
    $("#coinshift_monthly").highcharts "StockChart",
      chart:
        zoomType: 'xy'
      rangeSelector:
        selected: 0
        buttons: [{
          type: 'week'
          count: 1
          text: '1w'
        }, {
          type: 'week'
          count: 2
          text: '2w'
        }, {
          type: 'month'
          count: 1
          text: '1m'
      }]
      title:
        text: "Monthly Performance"
      series: [{
        name: "Hashrate (MH)"
        data: hashrate
      }, {
        name: "Reject Rate (MH)"
        data: rejectrate
      }
      ]

    $("#coinshift_btc").highcharts "StockChart",
      chart:
        zoomType: 'xy'
      rangeSelector:
        selected: 0
        buttons: [{
          type: 'week'
          count: 1
          text: '1w'
        }, {
          type: 'week'
          count: 2
          text: '2w'
        }, {
          type: 'month'
          count: 1
          text: '1m'
      }]
      title:
        text: "BTC/1MH Performance"
      series: [{
        name: "BTC/1MH (day)"
        data: btc_per_mh
      }]
