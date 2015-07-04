angular.module("SWAT").factory "RevisionMetrics", (SwatHelpers)->
  class RevisionMetrics
    constructor: (@revision, @tests, @fails)->

    data: ->
      result = []
      totalTests = @tests.length
      totalFailedTests = @fails.length
      totalDuration = _.sum(@tests, 'run_time')
      totalThreadDuration = _.sum(@revision.data.threads, 'total_runtime')
      successPercentage =  ((@tests.length - @fails.length) / @tests.length*100)

      result.push({ name: 'Revision Name', value: @revision.data.name })
      result.push({ name: 'Revision Status', value: @revision.data.status.name })
      result.push({ name: 'Revision Branch', value: @revision.data.branch })
      result.push({ name: 'Revisor', value: @revision.data.user })
      result.push({ name: 'Threads Count', value: @revision.data.threads_count })

      result.push({ name: 'Total Tests', value: totalTests })
      result.push({ name: 'Total Failed Tests', value: totalFailedTests })

      result.push({ name: 'Total Tests Duration', value: SwatHelpers.formatTime(totalDuration) })
      result.push({ name: 'Total Threads Duration', value: SwatHelpers.formatTime(totalThreadDuration) })

      result.push({ name: 'Success Percentage', value: (successPercentage.toFixed(2)+'%') })
      result