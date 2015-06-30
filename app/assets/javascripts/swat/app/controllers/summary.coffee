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

  $scope.initFails = ->
    $scope.summary.fails = _.select($scope.tests, (t)->(t.exception) )

  $scope.init()


