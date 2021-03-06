debug  = require('debug') 'nightmare:actions'
script = require './script'

module.exports = (fn, args...) ->
  debug '.evaluate() fn on the page'

  done = args.pop()

  unless typeof done is 'function'
    args.push done
    done = ->

  js = "(#{script}(#{String fn}, #{JSON.stringify args}))"

  @child.once 'javascript', (errstr, result) ->
    if errstr?
      errmsg    = JSON.parse errstr
      err       = new Error errmsg.message
      for k,v of errmsg
        err[k] = v
      done err
    else
      done null, JSON.parse result

  @child.emit 'javascript', js
  @
