# joseph [![Build Status][travis-image]][travis-url] [![Coverage Status][coveralls-image]][coveralls-url] [![NPM version][npm-image]][npm-url]  [![Gitter chat][gitter-image]][gitter-url]
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

[travis-url]:       https://travis-ci.org/zeekay/joseph
[travis-image]:     https://img.shields.io/travis/zeekay/joseph.svg
[coveralls-url]:    https://coveralls.io/github/zeekay/joseph?branch=master
[coveralls-image]:  https://coveralls.io/repos/zeekay/joseph/badge.svg?branch=master&service=github
[npm-url]:          https://www.npmjs.com/package/joseph
[npm-image]:        https://img.shields.io/npm/v/joseph.svg
[downloads-image]:  https://img.shields.io/npm/dm/joseph.svg
[downloads-url]:    http://badge.fury.io/js/joseph
[gitter-url]:       https://gitter.im/zeekay/hi
[gitter-image]:     https://badges.gitter.im/join-chat.svg
