angular.module("SWAT").controller "RevisionCtrl", ($rootScope, $scope, $state, $stateParams
  RevisionService) ->

  $scope.init = ->
    console.log($stateParams)
    console.log 'Swat Revision C initialized.'
    params = { branch: $stateParams.branch, user: $stateParams.user, time: $stateParams.time }
    RevisionService.get(params, (res)->
      $scope.revision = res
    )


  $scope.init()


