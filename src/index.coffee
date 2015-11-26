debug         = require('debug') 'nightmare'
evaluateAsync = require './evaluate-async'
script        = require './script'

module.exports = (Nightmare) ->
  Nightmare::evaluateAsync = (args...) ->
    debug 'queueing action "evaluateAsync"'
    @_queue.push [evaluateAsync, args]
    @
  Nightmare
