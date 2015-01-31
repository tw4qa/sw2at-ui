angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope) ->
  $scope.init = ->
    console.log('Root is ready to go!')

  $scope.init()
