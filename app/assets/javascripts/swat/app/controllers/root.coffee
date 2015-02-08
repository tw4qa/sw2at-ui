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

    suc = $scope.sum(_.map(items, (c)-> c.statusIndex = (if c.status=='success' then 1 else 0); c ), 'statusIndex')
    avg =
      run_time: $scope.avg(items, 'run_time')
      success: (values.count-suc)/values.count*100

    stats =
      last: last
      long: long
      short: short
      avg: avg
      times: items.count

    $scope.cases.push stats

  $scope.avg = (cases, attr)->
    sum = $scope.sum(cases, attr)
    sum/cases.length

  $scope.sum = (cases, attr)->
    sum = 0
    for c in cases
      sum = sum + c[attr]

    sum

  $scope.case = (json)->
    json.revision = new Date(json.revision)
    json.minutes = json.run_time.toFixed(2)
    json

  $scope.init()


