class GlResponseTransformer
  constructor: (@response) ->

  parse: ->
    JSON.parse(@response)

angular.module("SWAT").factory "GlResponse", ->
  (response)->
    new GlResponseTransformer(response).parse()