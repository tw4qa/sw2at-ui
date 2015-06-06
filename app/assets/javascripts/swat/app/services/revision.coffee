angular.module("SWAT").factory "RevisionService", ($resource) ->

  $resource "/swat/api/revisions", { id: "@id" },
    query:
      method: 'GET'
      isArray: true


