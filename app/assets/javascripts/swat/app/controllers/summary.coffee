angular.module("SWAT").controller "SummaryCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService) ->

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
    console.log($scope.tests)
    $scope.initFails()
    $scope.initExceptions()

  $scope.initFails = ->
    $scope.summary.fails = _.select($scope.tests, (t)->(t.exception) )

  $scope.initExceptions = ->
    groups = _.groupBy($scope.summary.fails, (f)->(f.exception.message) )
    console.log(groups)

    result = []
    for exMessage in _.keys(groups)
      exception =
        message: exMessage
        backtrace: groups[exMessage][0].exception.backtrace
        tests: groups[exMessage]
      result.push(exception)

    console.log(result)
    $scope.summary.exceptions = result

  $scope.init()


