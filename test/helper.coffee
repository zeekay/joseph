chai = require 'chai'
chai.should()
chai.use require 'chai-as-promised'

Nightmare = require 'nightmare'
require('../lib') Nightmare

before ->
  browser = Nightmare
    show: process.env.VERBOSE == 'true'
  yield browser.goto 'about:config'
  global.browser = browser

after ->
  yield browser.end()
