#= require_self
#
#= require_tree ./services
#= require_tree ./factories
#= require_tree ./controllers
#= require_tree ./directives

window.Swat =
  debug: true#false
  log: (message)->
    return unless window.Swat.debug
    console.log(message)

App = angular.module 'SWAT', [
  'ngResource'
  'ngRoute'
  'ui.router'
  'ui.bootstrap'
  'ngClipboard'
  'highcharts-ng'
  'ngtimeago'
  'ngCookies'
  'SWAT.components'
]

App.config ($urlRouterProvider, $stateProvider) ->
  $urlRouterProvider.otherwise("/swat/info/revisions")
  $stateProvider.state("revisions",
    url: "/swat/info/revisions"
    views:
      content:
        templateUrl: "/swat/pages/revisions/index.html"
        controller: 'RevisionsCtrl'
  )
  .state("revision",
    url: "/swat/info/revisions/:branch/:user/:time"
    views:
      content:
        templateUrl:  "/swat/pages/revisions/show.html"
        controller: 'RevisionCtrl'
  )
  .state("summary",
    url: "/swat/summary/revisions/:branch/:user/:time"
    views:
      content:
        templateUrl:  "/swat/pages/revisions/summary.html"
        controller: 'SummaryCtrl'
  )
  .state("configuration",
    url: "/swat/configuration"
    views:
      content:
        templateUrl:  "/swat/pages/management/configuration.html"
        controller: 'ConfigurationCtrl'
  )
  .state("console",
    url: "/swat/console"
    views:
      content:
        templateUrl:  "/swat/pages/management/console.html"
        controller: 'ConsoleCtrl'
  )
App.config(['ngClipProvider', (ngClipProvider)->
  ngClipProvider.setPath("/assets/swat/bower_components/zeroclipboard/dist/ZeroClipboard.swf")
])




