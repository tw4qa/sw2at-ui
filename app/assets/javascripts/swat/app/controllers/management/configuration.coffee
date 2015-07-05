angular.module("SWAT").controller "ConfigurationCtrl", ($rootScope, $scope, $state, $stateParams, $timeout
                                                        ConfigurationService) ->
  $scope.init = ->
    $timeout($scope.reloadConfig, 1000)
    $rootScope.globalControl.setReloader($scope.reloadConfig)

  $scope.reloadConfig = ->
    $scope.configPromise = ConfigurationService.get()
    $scope.configPromise.$promise.then((resp)->
      $scope.config = resp
    )

  $scope.init()
