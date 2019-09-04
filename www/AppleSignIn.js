var exec = require('cordova/exec');
var MODULE_NAME = "AppleSignIn";

var promiseWrapper = function(method) {
  return new Promise(function(resolve, reject) {
      var success = function(state) { resolve(state) }
      var failure = function(error) { reject(error) }
      exec(success, failure, MODULE_NAME, method, []);
  });
}
exports.startLogin = function () {
    return promiseWrapper('startLogin');
};

exports.isAvailable = function () {
  return promiseWrapper('isAvailable');
};
