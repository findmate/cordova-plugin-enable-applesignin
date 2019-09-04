var exec = require('cordova/exec');
var MODULE_NAME = "AppleSignIn";

var promiseWrapper = function(method) {
  return new Promise(function(resolve, reject) {
      var success = function(state) { resolve(state) }
      var failure = function(error) { reject(error) }
      exec(success, failure, MODULE_NAME, method, []);
  });
}
exports.getCredentialState = function (success, error) {
    return promiseWrapper('getCredentialState');
};

exports.isAvailable = function (success) {
  return promiseWrapper('isAvailable');
};
