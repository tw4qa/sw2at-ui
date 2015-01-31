angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, TestCaseService) ->
  $scope.init = ->
    $scope.title = 'S.W.A.T.'
    console.log('Root is ready to go!')
    tc = TestCaseService.query()
    console.log tc

  $scope.init()
