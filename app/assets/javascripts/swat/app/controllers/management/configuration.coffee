angular.module("SWAT").controller "ConfigurationCtrl", ($rootScope, $scope, $state, $stateParams
                                                        ConfigurationService) ->
  $scope.init = ->
    setTimeout($scope.reloadConfig, 1000);
    $rootScope.globalControl.setReloader($scope.reloadConfig)

  $scope.reloadConfig = ->
    $scope.configPromise = ConfigurationService.get()
    $scope.configPromise.$promise.then((resp)->
      $scope.config = resp
    )

  $scope.init()
