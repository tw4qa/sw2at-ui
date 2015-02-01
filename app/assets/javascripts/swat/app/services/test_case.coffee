console.log 'Service initialized'
angular.module("SWAT").factory "TestCaseService", ($resource) ->

  $resource "/swat/api/test_cases", { id: "@id" },
    query:
      method: 'GET'
      isArray: true


