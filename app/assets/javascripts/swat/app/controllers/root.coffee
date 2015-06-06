console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope,
    TestCaseService, RevisionService) ->

  $scope.init = ->
    $scope.initNamespaces()

  $scope.initNamespaces = ->
    RevisionService.query((response)-> $scope.revisions = response )

  $scope.goToRevision = (revision)->
    opts = JSON.stringify({ branch: revision.branch, user: revision.user, time: revision.time })
    path = "/swat/api/revision?options="+opts
    window.location = path

  $scope.init()


