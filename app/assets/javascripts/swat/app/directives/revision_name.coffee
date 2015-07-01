angular.module("SWAT").directive "revisionName", ($document, RevisionService)->
  restrict: 'AE'
  replace: true
  templateUrl: '/swat/pages/revisions/name.html'
  scope:
    revision: '='

  controller: ($scope, $attrs, $timeout)->
    $scope.init = ->
      $scope.id = ('revision-name-'+$scope.revision.data.time+Math.floor(Math.random()*1000))
      $scope.name = ($scope.revision.data.name || $scope.revision.data.time)

    $scope.delayedSave = ->
      $timeout($scope.save, 0)

    $scope.save = ->
      value = angular.element('#'+$scope.id).text()
      window.Swat.log(value)

      return if value == $scope.name
      params = { branch: $scope.revision.data.branch, user: $scope.revision.data.user, time: $scope.revision.data.time, name: value }
      RevisionService.setName(params).$promise.then((resp)->
        window.Swat.log(resp)
        $scope.name = value
      )

    $scope.init()