module.exports = String (fn, args) ->
  log    = console.log
  ipc    = __nightmare.ipc
  sliced = __nightmare.sliced

  # Swap out console.log
  console.log = ->
    log.apply console, arguments
    ipc.send 'log', (sliced arguments).map String

  # Return with results
  done = (err, response) ->
    if err
      errmsg = Object.assign {}, err
      errmsg.message = err.message
      errmsg.name    = err.name
      errmsg.stack   = err.stack

      ipc.send 'error', JSON.stringify errmsg
    else
      ipc.send 'response', response

    # Put console.log back
    console.log = log

  # Various helpers
  isAsync = (fn) ->
    fn.length == args.length + 1

  isGenerator = (fn) ->
    typeof fn is 'function' and /^function[\s]*\*/.test fn

  isPromise = (v) ->
    typeof v?.then is 'function'

  waitForPromise = (promise) ->
    promise
      .then (value) ->
        done null, value
      .catch (err) ->
        done err

  # Evaluation strategies
  evalAsync = ->
    args.push (err, res) ->
      return done err if err
      done null, res
    fn.apply null, args

  evalGenerator = ->
    gen = fn.apply null, args

    last = null
    prev = null

    next = (value) ->
      try
        res = gen.next value
      catch err
        return done err

      prev = last
      last = res.value

      if isPromise promise = res.value
        promise
          .then (value) ->
            next value
          .catch (err) ->
            done err
      else if not res.done
        next res.value
      else
        done null, (last ? prev)

    next()

  evalSync = -> fn.apply null, args

  return evalAsync()     if isAsync fn
  return evalGenerator() if isGenerator fn

  try
    response = evalSync()
  catch err
    return done err

  return waitForPromise response if isPromise response

  done null, response
