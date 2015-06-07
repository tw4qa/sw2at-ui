angular.module("SWAT").controller "RevisionsCtrl", ($rootScope, $scope, RevisionService)->

  $scope.init = ->
    console.log('Revisions Controller initalized!')
    $scope.initRevisions()

  $scope.initRevisions = ->
    RevisionService.query((response)-> $scope.revisions = response )

  $scope.goToRevision = (revision)->
    opts = JSON.stringify({ branch: revision.branch, user: revision.user, time: revision.time })
    path = "/swat/api/revision?options="+opts
    window.location = path

  $scope.init()
