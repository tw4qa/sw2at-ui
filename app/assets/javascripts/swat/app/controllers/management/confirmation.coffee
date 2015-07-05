angular.module("SWAT").controller "ConfirmationCtrl", ($rootScope, $scope, $modalInstance, action, message, SwatHelpers)->
  $scope.init = ->
    $scope.action = action
    $scope.message = message
    $scope.helpers = SwatHelpers

  $scope.ok = ->
    $scope.action()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.init()
