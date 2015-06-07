angular.module("SWAT").controller "RevisionsCtrl", ($rootScope, $scope, $state, RevisionService)->

  $scope.init = ->
    console.log('Revisions Controller initalized!')
    $scope.initRevisions()

  $scope.initRevisions = ->
    RevisionService.query((response)-> $scope.revisions = response )

  $scope.goToRevision = (revision)->
    $state.go('revision', revision)

  $scope.init()
