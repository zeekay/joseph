# nightmare-evaluate-async
Adds `evaluateAsync` method to
[Nightmare](https://github.com/segmentio/nightmare). You can use
`evaluateAsync` to evaluate asynchronous code and callback with the result.

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
  var res = yield nightmare
    .evaluateAsync(function(cb) {
      setTimeout(function() {
        cb("delayed")
      }, 1000)
    });
  console.log(res);
  yield nightmare.end();
}
```
