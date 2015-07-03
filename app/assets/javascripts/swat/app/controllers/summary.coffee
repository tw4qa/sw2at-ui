angular.module("SWAT").controller "SummaryCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService, FailsGraph, SwatHelpers) ->

  $scope.init = ->
    $scope.summary = {}
    $scope.reloadData()

  $scope.reloadData = ->
    return if $scope.revisionPromise && !$scope.revisionPromise.$resolved
    params = { branch: $stateParams.branch, user: $stateParams.user, time: $stateParams.time }
    $scope.revisionPromise = RevisionService.get(params)
    $scope.revisionPromise.$promise.then($scope.initInformation)

  $scope.initInformation = (revision)->
    $scope.revision = revision
    $scope.tests = _.flatten(_.map($scope.revision.data.threads, (thread)-> thread.tests || []))
    window.Swat.log($scope.tests)
    $scope.initFails()
    $scope.initExceptions()
    $scope.initMetrics()
    $scope.initFailsStatsGraph()

  $scope.initFails = ->
    $scope.summary.fails = _.select($scope.tests, (t)->(t.exception) )

  $scope.initExceptions = ->
    groups = _.groupBy($scope.summary.fails, (f)->(f.exception.message) )
    window.Swat.log(groups)

    result = []
    for exMessage in _.keys(groups)
      exception =
        message: exMessage
        backtrace: groups[exMessage][0].exception.backtrace
        tests: groups[exMessage]
      result.push(exception)

    window.Swat.log(result)
    $scope.summary.exceptions = result

  $scope.initFailsStatsGraph = ->
    $scope.failsStats = new FailsGraph($scope.tests, $scope.summary.fails)

  $scope.initMetrics = ->
    result = []
    totalTests = $scope.tests.length
    totalFailedTests = $scope.summary.fails.length
    totalDuration = _.sum($scope.tests, 'run_time')
    totalThreadDuration = _.sum($scope.revision.data.threads, 'total_runtime')
    successPercentage =  (($scope.tests.length - $scope.summary.fails.length) / $scope.tests.length*100)

    result.push({ name: 'Revision Name', value: $scope.revision.data.name })
    result.push({ name: 'Revision Status', value: $scope.revision.data.status.name })
    result.push({ name: 'Revision Branch', value: $scope.revision.data.branch })
    result.push({ name: 'Revisor', value: $scope.revision.data.user })
    result.push({ name: 'Threads Count', value: $scope.revision.data.threads_count })

    result.push({ name: 'Total Tests', value: totalTests })
    result.push({ name: 'Total Failed Tests', value: totalFailedTests })

    result.push({ name: 'Total Tests Duration', value: SwatHelpers.formatTime(totalDuration) })
    result.push({ name: 'Total Threads Duration', value: SwatHelpers.formatTime(totalThreadDuration) })

    result.push({ name: 'Success Percentage', value: (successPercentage.toFixed(2)+'%') })

    $scope.summary.metrics = result

  $scope.init()


