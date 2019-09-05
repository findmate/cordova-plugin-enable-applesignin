Cordova Plugin for Sign in with Apple
=====================================
Enables cordova apps to use the new [**Sign in with Apple**](https://developer.apple.com/sign-in-with-apple/) feature what will be required for all iOS apps using any social login. 

**Prerequisites**:
* A Cordova 3.0+ project for iOS
* XCode 11 (currently on beta)

# Installation

To install this plugin, follow the Command-line Interface Guide. You can use the following command line:
```
cordova plugin add cordova-plugin-applesignin 
```
Installing the plugin automatically adds the ```com.apple.developer.applesignin``` key to the entitlements to enable **Sign in with Apple** capability.
# Javascript API
**Note:** All API functions are returning Promises. In case of errors the returned promise is rejected with a string error message.
There are two public functions are available. 

### isAvailable 
Checks the availability of the feature. The returned promise is resolving with true for iOS13+

### startLogin 
Starts the login proccess. Returned Promise resolves with the returned login data or rejects with an error message. Cancelled login is also considered as a rejection. 

Example usage:

```
AppleSignIn.startLogin()  
  .then((res) => {
    console.log('success', res)
  })
  .catch((err) => {
    console.log('error', err)
  }) 
```

In case of successful signin the returned promise resolves with an object containing the following keys:
```
{
  email: "zoltan@powerednow.com",
  familyName: "Magyar",
  givenName: "Zoltan",
  user: "xxxxxx.4a9eb79a00384d3ab64f9d88902811ec.xxxx",
}
```
In case of error the promise is rejected with the following strings:
* "Cancelled" - ASAuthorizationErrorCanceled
* "Failed" - ASAuthorizationErrorFailed
* "Invalid" - ASAuthorizationErrorInvalidResponse
* "Not Handled" - ASAuthorizationErrorNotHandled:
* "Unknown" - ASAuthorizationErrorUnknown

See [Apple Documentation](https://developer.apple.com/documentation/authenticationservices/asauthorizationerror?language=objc) for the description of the errors.
