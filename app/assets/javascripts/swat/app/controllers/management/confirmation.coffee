angular.module("SWAT").controller "ConfirmationCtrl", ($rootScope, $scope, $sce, $modalInstance, action, message)->
  $scope.init = ->
    $scope.action = action
    $scope.message = message

  $scope.renderHtml = (htmlCode)->
    $sce.trustAsHtml(htmlCode)

  $scope.ok = ->
    $scope.action()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  $scope.init()
