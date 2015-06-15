#= require_self
#
#= require_tree ./services
#= require_tree ./factories
#= require_tree ./controllers


App = angular.module 'SWAT', [
  'ngResource'
  'ngRoute'
  'ui.router'
  'ui.bootstrap'
  'ngClipboard'
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
App.config(['ngClipProvider', (ngClipProvider)->
  ngClipProvider.setPath("assets/swat/bower_components/zeroclipboard/dist/ZeroClipboard.swf")
])




