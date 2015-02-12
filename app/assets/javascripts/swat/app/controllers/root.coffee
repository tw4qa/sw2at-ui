console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope,
    TestCaseService, TestCaseAnalyzer, NamespaceService, NamespaceAnalyzer) ->

  $scope.init = ->
    $scope.initTestCases()
    $scope.initNamespaces()

  $scope.initTestCases = ->
    $scope.cases = null
    console.log($scope.currentSelection())
    TestCaseService.query({options: $scope.currentSelection()}, (cases)->
      $scope.cases = (new TestCaseAnalyzer(cases)).analyze()
      console.log($scope.cases)
    )

  $scope.initNamespaces = ->
    NamespaceService.query((namespaces)->
      console.log(namespaces)
      $scope.namespaces = new NamespaceAnalyzer(namespaces).analyze()
    )

  $scope.currentSelection = ->
    return {} unless $scope.namespaces
    new NamespaceAnalyzer().currentSelection($scope.namespaces)

  $scope.init()


