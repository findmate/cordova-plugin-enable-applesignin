Cordova Plugin to Enable Sign in with Apple
=====================================
Enables cordova apps to use the new [**Sign in with Apple**](https://developer.apple.com/sign-in-with-apple/) feature what will be required for all iOS apps using any social login. 

**Prerequisites**:
* A Cordova 3.0+ project for iOS
* XCode 11 (currently on beta)

# Installation

To install this plugin, follow the Command-line Interface Guide. You can use the following command line:
```
cordova plugin add https://github.com/findmate/cordova-plugin-enable-applesignin
```
Installing the plugin automatically adds the ```com.apple.developer.applesignin``` key to the entitlements to enable **Sign in with Apple** capability.

# Credits
* This plugin was forked from: https://github.com/zmagyar/cordova-plugin-applesignin
* I just needed to enable the entitlement, which is a feature missing from the awesome plugin https://github.com/dpa99c/cordova-plugin-firebasex

See [Apple Documentation](https://developer.apple.com/documentation/authenticationservices/asauthorizationerror?language=objc) for the description of the errors.
