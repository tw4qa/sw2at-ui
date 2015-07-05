angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams,
    ConfirmationDialog) ->

  $scope.init = ->
    $scope.clean =
      branch: { name: '' }

  $scope.removeByBranch = ->
    message = 'Are you sure you want to remove branch <strong>' + $scope.clean.branch.name + '<strong>?'
    action =  -> alert('Wow')
    new ConfirmationDialog(message, action)

  $scope.init()
