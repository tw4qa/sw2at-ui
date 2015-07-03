angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, $state, SwatHelpers) ->

  $scope.init = ->
    $scope.helpers = SwatHelpers
    window.Swat.log 'Swat Root initialized.'

  $scope.init()


