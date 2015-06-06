console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope,
    TestCaseService, RevisionService) ->

  $scope.init = ->
    $scope.initNamespaces()

  $scope.initNamespaces = ->
    RevisionService.query((response)-> $scope.revisions = response )

  $scope.init()


