angular.module("SWAT").controller "ConsoleCtrl", ($rootScope, $scope, $state, $stateParams #,ConsoleService
                                                        ) ->
  $scope.init = ->
    $scope.clean =
      branch: { name: '' }


  $scope.init()
