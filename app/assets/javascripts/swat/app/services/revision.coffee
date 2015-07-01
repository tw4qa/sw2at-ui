angular.module("SWAT").factory "RevisionService", ($resource, GlResponse, RevisionModelFactory) ->

  $resource "/swat/api/revisions", { id: "@id", branch: '@branch', user: '@user', time: '@time', name: '@name' },
    query:
      method: 'GET'
      isArray: true
      transformResponse: RevisionModelFactory

    get:
      url: '/swat/api/revision'
      method: 'GET'
      transformResponse: RevisionModelFactory

    setName:
      url: '/swat/api/revision/name/:name'
      method: 'PUT'
      transformResponse: GlResponse




