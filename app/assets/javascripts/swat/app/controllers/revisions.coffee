angular.module("SWAT").controller "RevisionsCtrl", ($rootScope, $scope, $state, RevisionService)->

  $scope.init = ->
    window.Swat.log('Revisions Controller initalized!')
    $rootScope.globalControl.setReloader($scope.initRevisions)
    $rootScope.globalControl.reload()

  $scope.initRevisions = ->
    $scope.revisionsPromise = RevisionService.query()
    $scope.revisionsPromise.$promise.then((resp)->
      $scope.revisions = resp
    )
    $scope.revisionsPromise

  $scope.testsProgress = (revision)->

    startedThreads = revision.data.threads.length
    totalThreads = revision.data.threads_count

    completedThreads = _.select(revision.data.threads, (t)->t.status && t.status.completed)
    completedTests = _.sum( completedThreads, (t)-> t.total_examples)
    totalTests = _.sum( revision.data.threads, (t)-> t.total_examples)

    completedThreads.length + " threads completed of " + totalThreads + ". (" + totalTests + " tests in total)"

  $scope.init()
