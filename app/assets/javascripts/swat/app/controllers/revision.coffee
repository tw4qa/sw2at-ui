angular.module("SWAT").controller "RevisionCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService) ->

  $scope.init = ->
    $scope.currentState = $state.current.name
    $scope.reloadData()
    $rootScope.globalControl.setReloader($scope.reloadData)

  $scope.reloadData = ->
    return if $scope.revisionPromise && !$scope.revisionPromise.$resolved
    params = { branch: $stateParams.branch, user: $stateParams.user, time: $stateParams.time }
    $scope.revisionPromise = RevisionService.get(params)
    $scope.revisionPromise.$promise.then($scope.initTabs)

  $scope.initTabs = (revision)->
    $scope.revision = revision
    $scope.tabs = [] unless $scope.tabs
    for thread in $scope.revision.data.threads
      existingTab = _.find($scope.tabs, (tab)->tab.thread.thread_id == thread.thread_id )
      if existingTab
        existingTab.thread = thread
      else
        $scope.tabs.push({ thread: thread })

  $scope.init()


