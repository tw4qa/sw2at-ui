angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope) ->
  $scope.init = ->
    $scope.title = 'S.W.A.T.'
    console.log('Root is ready to go!')

  $scope.init()
