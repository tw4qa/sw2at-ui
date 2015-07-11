angular.module("SWAT").controller "SummaryCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService, FailsGraph, RevisionMetrics, ExceptionGroups) ->

  $scope.init = ->
    $scope.currentState = $state.current.name
    $scope.summary = {}
    $rootScope.globalControl.setReloader($scope.reloadData)
    $rootScope.globalControl.reload()

  $scope.reloadData = ->
    return $scope.revisionPromise if $scope.revisionPromise && !$scope.revisionPromise.$resolved
    params = { branch: $stateParams.branch, user: $stateParams.user, time: $stateParams.time }
    $scope.revisionPromise = RevisionService.get(params)
    $scope.revisionPromise.$promise.then($scope.initInformation)
    $scope.revisionPromise

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
    $scope.summary.exceptions = new ExceptionGroups($scope.summary.fails).data()

  $scope.initFailsStatsGraph = ->
    $scope.failsStats = new FailsGraph($scope.tests, $scope.summary.fails)

  $scope.initMetrics = ->
    $scope.summary.metrics  = new RevisionMetrics($scope.revision, $scope.tests, $scope.summary.fails).data()

  $scope.init()


