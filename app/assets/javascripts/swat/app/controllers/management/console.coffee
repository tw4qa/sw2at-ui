angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams,
    ConfirmationDialog, ConsoleService) ->

  $scope.init = ->
    $scope.clean =
      branch: { name: '' }
      user: { name: '' }
      period: { name: '' }
      revision: { name: '' }
    $rootScope.globalControl.setReloader($scope.loadConsoleData)
    $rootScope.globalControl.reload()


  $scope.loadConsoleData = ->
    $scope.consoleDataPromise = ConsoleService.data()
    $scope.consoleDataPromise.$promise.then((resp)->
      $scope.consoleData = resp
    )
    $scope.consoleDataPromise

  $scope.sum = (data)->
   _.sum(_.values(data))

  $scope.remove = (attribute)->
    message = 'Are you sure you want to remove revisions of ' + attribute + ' <strong>' + $scope.clean[attribute].name + '<strong>?'
    action =  ->
      promise = ConsoleService.clean(attribute: attribute, value: $scope.clean[attribute].name)
      promise.$promise.then($scope.loadConsoleData)
      promise

    new ConfirmationDialog(message, action)

  $scope.init()
