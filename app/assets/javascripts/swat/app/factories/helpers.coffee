angular.module("SWAT").factory "SwatHelpers", ->
  Helpers =
    formatTime: (seconds) ->
      hh = Math.floor(seconds / 3600)
      mm = Math.floor(seconds / 60) % 60
      ss = Math.floor(seconds) % 60
      (if hh then (if hh < 10 then '0' else '') + hh + ':' else '') + (if mm < 10 and hh then '0' else '') + mm + ':' + (if ss < 10 then '0' else '') + ss
