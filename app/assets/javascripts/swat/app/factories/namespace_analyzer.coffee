angular.module("SWAT").factory "NamespaceAnalyzer",  ->
  class NamespaceAnalyzer
    constructor: (@namespaces) ->

    analyze: ->
      res = {}
      res.branches = prepareList(@namespaces, 'branch')
      res.times = prepareList(@namespaces, 'time').reverse()
      res.users = prepareList(@namespaces, 'user')
      res

    prepareList = (items, field)->
      _.uniq(_.map(items, (ns)-> { name: ns[field], value: false, full: ns }), (ns)-> ns.name )


    currentSelection: (data)->
      b = _.map(_.select(data.branches, ((ns)-> ns.value)), ((ns)-> ns.name))
      r = _.map(_.select(data.times, ((ns)-> ns.value)), ((ns)-> ns.name))
      u = _.map(_.select(data.users, ((ns)-> ns.value)), ((ns)-> ns.name))
      { branch: b, time: r, user: u }



