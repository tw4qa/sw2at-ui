console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, TestCaseService) ->
  $scope.init = ->
    $scope.title = 'S.W.A.T.'
    console.log('Root is ready to go!')
    $scope.cases = TestCaseService.query()
    console.log($scope.cases)
  $scope.init()
