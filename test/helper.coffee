chai = require 'chai'
chai.should()
chai.use require 'chai-as-promised'

evaluateAsync = require '../lib'
Nightmare = evaluateAsync require 'nightmare'

before ->
  browser = Nightmare
    show: process.env.VERBOSE == 'true'
  yield browser.goto 'about:config'
  global.browser = browser

after ->
  yield browser.end()
