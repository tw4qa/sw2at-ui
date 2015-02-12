console.log 'Service initialized'
angular.module("SWAT").factory "NamespaceService", ($resource) ->

  $resource "/swat/api/namespaces", { id: "@id" },
    query:
      method: 'GET'
      isArray: true


