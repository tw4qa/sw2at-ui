angular.module("SWAT").controller "SummaryCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService, FailsGraph) ->

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
    return
    $scope.failsStats =1


  $scope.init()


