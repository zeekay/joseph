describe 'nightmare-evaluate-async', ->
  it 'should support node.js style callbacks', ->
    res = yield browser.evaluateAsync (cb) ->
      cb null, 1
    res.should.eq 1

    p = browser.evaluateAsync (cb) ->
        setTimeout ->
          cb new Error 'eep'
        , 10

    (do ->  yield p).next.should.throw Error

  it 'should wait for promise to complete', ->
    res = yield browser.evaluateAsync ->
      Promise.resolve 2
    res.should.eq 2

  it 'should handle promise rejection', ->
    p = browser.evaluateAsync ->
        Promise.reject new Error 'ohno'
    (do ->  yield p).next.should.throw Error

  it 'should pass in arguments correctly', ->
    res = yield browser.evaluateAsync (a, b, c) ->
      Promise.resolve a + b + c
    , 1, 2, 3
    res.should.eq 6

  it 'should consume generators', ->
    res = yield browser.evaluateAsync ->
      res = yield Promise.resolve 7
      res
    res.should.eq 7

    res = yield browser.evaluateAsync ->
      yield Promise.resolve 8
    res.should.eq 8

    res = yield browser.evaluateAsync ->
      yield Promise.resolve 9
      yield Promise.resolve 10
      yield Promise.resolve 11
      12
    res.should.eq 12

  xit 'should handle asynchronicity correctly', ->
    p = browser.evaluateAsync ->
        Promise.reject new Error 'ohno'
    # Why doesn't this work?
    yield p.next.should.throw Error
