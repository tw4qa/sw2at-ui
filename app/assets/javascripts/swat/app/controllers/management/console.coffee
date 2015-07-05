angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams #,ConsoleService
                                                  $modal) ->
  $scope.init = ->
    $scope.clean =
      branch: { name: '' }


  $scope.removeByBranch = ->
    $modal.open(
      size: 'sm',
      templateUrl: '/swat/pages/management/confirmation.html',
      controller: 'ConfirmationCtrl',
      resolve:
        action: ->
          -> alert('Wow')
        message: ->
          'Are you sure you want to remove branch <strong>' + $scope.clean.branch.name + '<strong>?'
    )

  $scope.init()
