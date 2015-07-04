angular.module("SWAT").controller "ConfigurationCtrl", ($rootScope, $scope, $state, $stateParams
                                                        ConfigurationService) ->
  $scope.init = ->
    $scope.config = ConfigurationService.get()

  $scope.init()
