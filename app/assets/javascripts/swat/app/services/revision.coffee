angular.module("SWAT").factory "RevisionService", ($resource) ->

  $resource "/swat/api/revisions", { id: "@id", branch: '@branch', user: '@user', time: '@time' },
    query:
      method: 'GET'
      isArray: true
    get:
      url: '/swat/api/revision'
      method: 'GET'




