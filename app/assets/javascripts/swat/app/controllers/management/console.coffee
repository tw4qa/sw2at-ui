angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams,
    ConfirmationDialog, ConsoleService) ->

  $scope.init = ->
    $scope.clean =
      branch: { name: '' }

    $scope.loadConsoleData()
    $rootScope.globalControl.setReloader($scope.loadConsoleData)


  $scope.loadConsoleData = ->
    $scope.consoleDataPromise = ConsoleService.data()
    $scope.consoleDataPromise.$promise.then((resp)->
      $scope.consoleData = resp
    )


  $scope.removeByBranch = ->
    message = 'Are you sure you want to remove branch <strong>' + $scope.clean.branch.name + '<strong>?'
    action =  -> alert('Wow')
    new ConfirmationDialog(message, action)

  $scope.init()
