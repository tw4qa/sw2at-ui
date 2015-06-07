angular.module("SWAT").factory "RevisionService", ($resource, RevisionModelFactory) ->

  $resource "/swat/api/revisions", { id: "@id", branch: '@branch', user: '@user', time: '@time' },
    query:
      method: 'GET'
      isArray: true
      transformResponse: RevisionModelFactory

    get:
      url: '/swat/api/revision'
      method: 'GET'
      transformResponse: RevisionModelFactory




