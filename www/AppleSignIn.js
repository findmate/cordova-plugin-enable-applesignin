var exec = require('cordova/exec');
var MODULE_NAME = "AppleSignIn";

var promiseWrapper = function(method, theArgs = []) {
  return new Promise(function(resolve, reject) {
    var success = function(state) { resolve(state) }
    var failure = function(error) { reject(error) }
    exec(success, failure, MODULE_NAME, method, theArgs);
  });
}

exports.startLogin = function (userId = '') {
  return promiseWrapper('startLogin', [userId]);
};

exports.isAvailable = function () {
  return promiseWrapper('isAvailable');
};
               
exports.isUserAuthorized = function (userId) {
  return promiseWrapper('isUserAuthorized', [userId]);
};