module.exports = String (fn, args) ->
  log    = console.log
  ipc    = __nightmare.ipc
  sliced = __nightmare.sliced

  console.log = ->
    ipc.send 'log', (sliced arguments).map String

  done = (err, response) ->
    if err
      errmsg =
        message: err.message
        name:    err.name
        stack:   err.stack
      ipc.send 'error', JSON.stringify errmsg
    else
      ipc.send 'response', response

    console.log = log

  # Evaluate code
  try
    response = fn.apply null, args
  catch err
    return done err

  # Handle Promises
  if typeof response.then is 'function'
    response
      .then (value) ->
        done null, value
      .catch (err) ->
        done err
    return

  done null, response
