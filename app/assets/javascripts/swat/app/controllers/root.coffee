console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope,
    TestCaseService, TestCaseAnalyzer, NamespaceService) ->

  $scope.init = ->
    $scope.initNamespaces()

  $scope.initNamespaces = ->
    NamespaceService.query((namespaces)-> $scope.namespaces = namespaces )

  $scope.init()


