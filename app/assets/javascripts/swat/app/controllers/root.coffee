angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, $state) ->

  $scope.init = ->
    window.Swat.log 'Swat Root initialized.'

  $scope.init()


