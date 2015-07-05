angular.module("SWAT").factory "ConfigurationService", ($resource, GlResponse) ->
  $resource "/swat/api/configuration", {},
    get:
      method: 'GET'
      transformResponse: GlResponse
