describe 'jospeh', ->
  it 'should evaluate synchronous functions', ->
    res = yield browser.evaluate -> 42
    res.should.eq 42

  it 'should support node.js style callbacks', ->
    res = yield browser.evaluate (cb) ->
      cb null, 1
    res.should.eq 1

    p = browser.evaluate (cb) ->
        setTimeout ->
          cb new Error 'eep'
        , 10

    (do ->  yield p).next.should.throw Error

  it 'should wait for promise to complete', ->
    res = yield browser.evaluate ->
      Promise.resolve 2
    res.should.eq 2

  it 'should handle promise rejection', ->
    p = browser.evaluate ->
        Promise.reject new Error 'ohno'
    (do ->  yield p).next.should.throw Error

  it 'should pass in arguments correctly', ->
    res = yield browser.evaluate (a, b, c) ->
      Promise.resolve a + b + c
    , 1, 2, 3
    res.should.eq 6

  it 'should consume generators', ->
    res = yield browser.evaluate ->
      res = yield Promise.resolve 7
      res
    res.should.eq 7

    res = yield browser.evaluate ->
      yield Promise.resolve 8
    res.should.eq 8

    res = yield browser.evaluate ->
      yield Promise.resolve 9
      yield Promise.resolve 10
      yield Promise.resolve 11
      12
    res.should.eq 12

  it 'should catch errors thrown in a generator', ->
    try
      yield browser.evaluate ->
        f = ->
          throw new Error 'darn'
        yield f()
    catch err
    String(err).should.eq 'Error: darn'

  xit 'should handle asynchronicity correctly', ->
    p = browser.evaluate ->
        Promise.reject new Error 'ohno'
    # Why doesn't this work?
    yield p.next.should.throw Error
