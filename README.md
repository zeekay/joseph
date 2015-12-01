# joseph [![Build Status](https://travis-ci.org/zeekay/joseph.svg?branch=master)](https://travis-ci.org/zeekay/joseph) [![npm version](https://badge.fury.io/js/joseph.svg)](https://badge.fury.io/js/joseph)
##### Do promises and asynchronous code give you nightmares? We're here to help!

Updates Nightmare's `evaluate` with support for promises, Node.js style
callbacks, generators and more.

## Install
```bash
$ npm install joseph
```

## Usage
```javascript

// Patch Nightmare
var Nightmare = require('joseph')(require('nightmare'))
// ...or
var Nightmare = require('joseph/nightmare');

function *run() {
  var nightmare = Nightmare();

  // Go somewhere
  nightmare.goto('about:config')

  // Return promises
  var res = yield nightmare.evaluate(function() {
    return Promise.resolve('promise all the things')
  });
  console.log(res);

  // Generators for control-flow
  var res = yield nightmare.evaluate(function *() {
    var msg = '';
    msg += yield Promise.resolve('generators');
    msg += yield Promise.resolve(' + ');
    msg += yield Promise.resolve('promises');
    msg += yield Promise.resolve(' = <3 ');
    yield msg;
  });
  console.log(res);

  // Callbacks are okay too!
  var res = yield nightmare.evaluate(function (cb) {
    cb(null, 'callbacks are still hip')
  });
  console.log(res);

  yield nightmare.end();
}

// Run with vo
require('vo')(run)(function (err) {
  if (err) console.error(err.stack);
});
```
