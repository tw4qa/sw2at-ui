angular.module("SWAT").factory "NamespaceAnalyzer",  ->
  class NamespaceAnalyzer
    constructor: (@namespaces) ->

    analyze: ->
      res = {}
      res.branches = prepareList(@namespaces, 'branch')
      res.revisions = prepareList(@namespaces, 'revision').reverse()
      res.users = prepareList(@namespaces, 'user')
      res

    prepareList = (items, field)->
      un = _.uniq(_.map(items, (ns)-> ns[field] ))
      _.map(un, (ns)-> { name: ns, value: false })


    currentSelection: (data)->
      b = _.map(_.select(data.branches, ((ns)-> ns.value)), ((ns)-> ns.name))
      r = _.map(_.select(data.revisions, ((ns)-> ns.value)), ((ns)-> ns.name))
      u = _.map(_.select(data.users, ((ns)-> ns.value)), ((ns)-> ns.name))
      { branch: b, revision: r, user: u }



