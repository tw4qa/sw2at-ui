angular.module("SWAT").controller "ConfirmationCtrl", ($rootScope, $scope, $modalInstance, action, message, SwatHelpers)->
  $scope.init = ->
    $scope.action = action
    $scope.message = message
    $scope.helpers = SwatHelpers

  $scope.ok = ->
    result = $scope.action()
    unless result.$promise
      $modalInstance.close()
    else
      $scope.waitingAction = true
      result.$promise.then(->
        $scope.waitingAction = false
        $modalInstance.close()
      )

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.init()
