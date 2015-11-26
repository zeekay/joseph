debug    = require('debug') 'nightmare'
evaluate = require './evaluate'
script   = require './script'

module.exports = (Nightmare) ->
  Nightmare::evaluate = (args...) ->
    debug 'queueing action "evaluate"'
    @_queue.push [evaluate, args]
    @
  Nightmare
