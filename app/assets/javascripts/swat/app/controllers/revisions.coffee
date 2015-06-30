angular.module("SWAT").controller "RevisionsCtrl", ($rootScope, $scope, $state, RevisionService)->

  $scope.init = ->
    window.Swat.log('Revisions Controller initalized!')
    $scope.initRevisions()

  $scope.initRevisions = ->
    $scope.revisions = RevisionService.query()

  $scope.init()
