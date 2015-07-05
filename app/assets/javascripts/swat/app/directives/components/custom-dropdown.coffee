angular.module("SWAT.components").directive "customDropdown", ($document)->
  restrict: 'AE'
  replace: true
  templateUrl: '/swat/pages/components/custom_dropdown.html'
  scope:
    model: '='
    options: '='
    modelAttr: '='
    emptyOption: '='
    placeholder: '='
    glTabIndex: '='
    afterUpdate: '&'
    glDisabled: '='

  controller: ($scope, $attrs, $timeout)->
    $scope.init = ->
      $scope.id = Math.random()*1000
      $scope.decorateOptions()
      $scope.$watch('options', $scope.decorateOptions)
      if $scope.placeholder && !$scope.model
        $scope.model = $scope.placeholder

    $scope.selectOption = (option)->
      $scope.reprocess = true
      $timeout(->
        $scope.afterUpdate() if $scope.afterUpdate
        $scope.reprocess = false
      , 0)

    $scope.decorateOptions = ->
      $scope.selectOptions = _.map($scope.options, (el)-> if $scope.modelAttr then el[$scope.modelAttr] else el )
      if $scope.placeholder
        $scope.selectOptions.unshift $scope.placeholder

    $scope.init()
