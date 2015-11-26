# joseph [![Build Status](https://travis-ci.org/zeekay/joseph.svg?branch=master)](https://travis-ci.org/zeekay/joseph)
#### Do promises and asynchronous code give you nightmares? We're here to help!

Updates Nightmare's `evaluate` with support for promises, Node.js style
callbacks, generators and more.

## Install
```bash
$ npm install joseph
```

## Usage
```javascript
var Nightmare = require('nightmare');
var vo = require('vo');

// Patch Nightmare
require('joseph')(Nightmare)

vo(run)(function(err, result) {
  if (err) throw err;
});

function *run() {
  var nightmare = Nightmare();

  // Return promises
  var res = yield nightmare.evaluate(function() {
    return Promise.resolve('promise all the things')
  });
  console.log(res);

  // Generators for control-flow
  var res = yield nightmare.evaluate(function *() {
    yield Promise.resolve('generators + promises = <3')
  });
  console.log(res);

  // Callbacks are okay too!
  var res = yield nightmare.evaluate(function (cb) {
    cb(null, 'callbacks are still hip')
  });
  console.log(res);

  yield nightmare.end();
}
```
