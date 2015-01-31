angular.module("SWAT").factory "TestCaseService", ($resource) ->

  $resource "/swat/api/tests", { id: "@id" },
    query:
      method: 'GET'
      isArray: true


