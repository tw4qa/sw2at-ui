angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams,
    ConfirmationDialog, ConsoleService) ->

  $scope.init = ->
    $scope.clean =
      branch: { name: '' }
      user: { name: '' }
      period: { name: '' }
      revision: { name: '' }

    $scope.loadConsoleData()
    $rootScope.globalControl.setReloader($scope.loadConsoleData)


  $scope.loadConsoleData = ->
    $scope.consoleDataPromise = ConsoleService.data()
    $scope.consoleDataPromise.$promise.then((resp)->
      $scope.consoleData = resp
    )

  $scope.sum = (data)->
   _.sum(_.values(data))

  $scope.remove = (attribute)->
    message = 'Are you sure you want to remove revisions of ' + attribute + ' <strong>' + $scope.clean[attribute].name + '<strong>?'
    action =  -> alert('Wow')
    new ConfirmationDialog(message, action)

  $scope.init()
