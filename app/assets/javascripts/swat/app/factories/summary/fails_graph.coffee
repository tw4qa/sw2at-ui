class FailsGraph
  constructor: (@tests, @fails) ->
  conf: ->

    res =
      options:
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          type: 'pie'
      credits: enabled: 'true'
      title:
        text: 'Fail Rate'

      tooltip:
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      plotOptions: pie:
        allowPointSelect: true
        cursor: 'pointer'
        dataLabels:
          enabled: true
          format:
            '<b>{point.name}</b>: {point.percentage:.1f} %'
          style:
            color:
              Highcharts.theme and Highcharts.theme.contrastTextColor or 'black'
      series: [ {
        name: 'Results'
        colors: [ '#1FEC33', '#EC243B', '#90ed7d', '#f7a35c', '#8085e9', '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1']
        colorByPoint: true
        data: [
          {
            name: 'Passed Examples'
            y: (@tests.length - @fails.length)
          }
          {
            name: 'Failed Examples'
            y: @fails.length
          }
        ]
      } ]

angular.module("SWAT").factory "FailsGraph", ->
  (tests, fails)->
    new FailsGraph(tests, fails).conf()