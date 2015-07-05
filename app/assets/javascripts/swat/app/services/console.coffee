angular.module("SWAT").factory "ConsoleService", ($resource, GlResponse) ->
  $resource "/swat/api/console", { attribute: '@attribute', value: '@value' },
    data:
      method: 'GET'

    clean:
      url: '/swat/api/console/clean/:attribute/:value'
      method: 'DELETE'