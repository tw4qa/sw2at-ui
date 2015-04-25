angular.module("SWAT").factory "TestCaseAnalyzer",  ->
  class TestCaseAnalyzer
    constructor: (@cases) ->

    analyze: ->
      groups = _.groupBy(@cases, 'full_description')
      data = {}
      data.groups = _.map(groups, @analyzeCase)
      data.summary = @summary(data.groups)
      data

    analyzeCase: (values, g)=>
      items = _.map(values, @case)
      last = _.max(items, (c)-> c.time )
      long = _.max(items, (c)-> c.run_time )
      short = _.max(items, (c)-> -c.run_time )

      avg =
        run_time: @avg(items, 'run_time')
        success: @success(items)

      stat =
        last: last
        long: long
        short: short
        avg: avg
        total: items.length
        successful: @sum(items, 'statusIndex')

    summary: (groups)->
      res =
        total: @sum(groups, 'total')
        total_success: @success(_.map(groups, ((e)->e.last)))
        total_runtime: Math.round((@sum(_.map(groups, ((e)->e.last)), 'run_time')/60))

    avg: (cases, attr)->
      sum = @sum(cases, attr)
      sum/cases.length

    sum: (cases, attr)->
      sum = 0
      for c in cases
        sum = sum + c[attr]

      sum

    success: (items)->
      (@sum(items, 'statusIndex')/items.length*100).toFixed(2)

    case: (json)->
      json.time = new Date(json.time)
      json.minutes = json.run_time.toFixed(2)
      json.statusIndex = (if json.status=='success' then 1 else 0)
      json

