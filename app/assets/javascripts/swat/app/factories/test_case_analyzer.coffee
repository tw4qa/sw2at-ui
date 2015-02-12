angular.module("SWAT").factory "TestCaseAnalyzer",  ->
  class TestCaseAnalyzer
    constructor: (@cases) ->

    analyze: ->
      groups = _.groupBy(@cases, 'full_description')
      _.map(groups, @analyzeCase)

    analyzeCase: (values, g)=>
      items = _.map(values, @case)
      last = _.max(items, (c)-> c.revision )
      long = _.max(items, (c)-> c.run_time )
      short = _.max(items, (c)-> -c.run_time )

      suc = @sum(_.map(items, (c)-> c.statusIndex = (if c.status=='success' then 1 else 0); c ), 'statusIndex')
      avg =
        run_time: @avg(items, 'run_time')
        success: (suc/values.length*100).toFixed(2)

      stat =
        last: last
        long: long
        short: short
        avg: avg
        total: items.length
        successful: suc

    avg: (cases, attr)->
      sum = @sum(cases, attr)
      sum/cases.length

    sum: (cases, attr)->
      sum = 0
      for c in cases
        sum = sum + c[attr]

      sum

    case: (json)->
      json.revision = new Date(json.revision)
      json.minutes = json.run_time.toFixed(2)
      json
