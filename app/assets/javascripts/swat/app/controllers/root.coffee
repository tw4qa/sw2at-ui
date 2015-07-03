angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, $state, SwatHelpers, GlobalControl) ->

  $scope.init = ->
    $scope.helpers = SwatHelpers
    window.Swat.log 'Swat Root initialized.'

    $rootScope.globalControl  = new GlobalControl()

  $scope.init()


