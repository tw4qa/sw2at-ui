angular.module("SWAT").factory "ConsoleService", ($resource, GlResponse) ->
  $resource "/swat/api/console", {},
    data:
      method: 'GET'
