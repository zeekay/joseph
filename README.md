# nightmare-evaluate-async
Adds `evaluateAsync` method to
[Nightmare](https://github.com/segmentio/nightmare). You can use
`evaluateAsync` to evaluate asynchronous code in Nightmare's browser context.

Supports Node.js style callbacks and Promises plus you can use generators for control-flow.

## Install
```bash
$ npm install nightmare-evaluate-async
```

## Usage
```javascript
var Nightmare = require('nightmare');
var vo = require('vo');

// Adds evaluateAsync method
require('nightmare-evaluate-async')(Nightmare)

vo(run)(function(err, result) {
  if (err) throw err;
});

function *run() {
  var nightmare = Nightmare();

  // Return promises
  var res = yield nightmare.evaluateAsync(function() {
    return Promise.resolve('promises')
  });
  console.log(res);

  // Generators for control-flow
  var res = yield nightmare.evaluateAsync(function *() {
    yield Promise.resolve('generators+promises=<3')
  });
  console.log(res);

  // Callbacks are okay too!
  var res = yield nightmare.evaluateAsync(function (cb) {
    cb(null, "callback")
  });
  console.log(res);

  yield nightmare.end();
}
```
