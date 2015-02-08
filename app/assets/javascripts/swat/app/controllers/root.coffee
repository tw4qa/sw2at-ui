console.log 'Root C. initialized'
angular.module("SWAT").controller "RootCtrl", ($rootScope, $scope, TestCaseService) ->
  $scope.init = ->
    $scope.title = 'S.W.A.T.'
    console.log('Root is ready to go!')
    TestCaseService.query((cases)->
      console.log(cases)
      $scope.cases = []
      $scope.analyzeCases(cases)
      console.log($scope.cases)
    )

  $scope.analyzeCases = (casesList)->
    groups = _.groupBy(casesList, 'full_description')
    angular.forEach(groups, $scope.analyzeCase)


  $scope.analyzeCase = (values, g)->
    items = _.map(values, $scope.case)
    last = _.max(items, (c)-> c.revision )
    long = _.max(items, (c)-> c.run_time )
    short = _.max(items, (c)-> -c.run_time )

    avg =
      run_time: $scope.avg(items, 'run_time')
      success: $scope.avg(_.map(items, (c)-> c.status = (if c.status=='success' then 1 else 0) ), 'status')

    stats =
      last: last
      long: long
      short: short
      avg: avg

    $scope.cases.push stats

  $scope.avg = (cases, attr)->
    sum = $scope.sum(cases, attr)
    sum/cases.length

  $scope.sum = (cases, attr)->
    cases.reduce(
      (a,b)-> a[attr]+b[attr],
      0
    )

  $scope.case = (json)->
    json.revision = new Date(json.revision)
    json.minutes = json.run_time.toFixed(2)
    json

  $scope.init()


