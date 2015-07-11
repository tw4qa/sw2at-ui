angular.module("SWAT").controller "ConfigurationCtrl", ($rootScope, $scope, $state, $stateParams, $timeout
                                                        ConfigurationService) ->
  $scope.init = ->
    $rootScope.globalControl.setReloader($scope.reloadConfig)
    #$timeout($rootScope.globalControl.reload, 1000)
    $rootScope.globalControl.reload()


  $scope.reloadConfig = ->
    $scope.configPromise = ConfigurationService.get()
    $scope.configPromise.$promise.then((resp)->
      $scope.config = resp
    )
    $scope.configPromise


  $scope.init()
