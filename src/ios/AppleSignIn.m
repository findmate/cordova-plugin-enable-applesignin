/********* AppleSignIn.m Cordova Plugin Implementation *******/

#import "AppleSignIn.h"

@interface AppleSignIn () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@end

@implementation AppleSignIn

- (void)isAvailable:(CDVInvokedUrlCommand*)command {
  bool avail = false;
  if (@available(iOS 13.0, *)) {
    avail = true;
  }
  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:avail];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)startLogin:(CDVInvokedUrlCommand*)command {
  if (@available(iOS 13.0, *)) {
    NSString* userID = [command.arguments objectAtIndex:0];
    self.getCredentialStateCallbackId = command.callbackId;
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    request.requestedOperation = ASAuthorizationOperationLogin;
    if (![userID isEqualToString:@""]) {
      request.user = userID;
    }
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    controller.delegate = self;
    controller.presentationContextProvider = self;
    [controller performRequests];
  }
}

- (void)isUserAuthorized: (CDVInvokedUrlCommand*)command {
  if (@available(iOS 13.0, *)) {
    NSString* userID = [command.arguments objectAtIndex:0];
    NSLog(@"SignInWithApple check state for user %@", userID);
    int __block isAuthorized = false;
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    [appleIDProvider getCredentialStateForUserID:userID completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
        if (credentialState == ASAuthorizationAppleIDProviderCredentialAuthorized) {
          isAuthorized = true;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"SignInWithApple state %i", isAuthorized);
          [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isAuthorized] callbackId:command.callbackId];
        });
    }];
  }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)) {

  NSLog(@"authorization.credential：%@", authorization.credential);

  NSDictionary *authResult;
  if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
    ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
    NSString *user = appleIDCredential.user;
    NSString *familyName = appleIDCredential.fullName.familyName;
    NSString *givenName = appleIDCredential.fullName.givenName;
    NSString *email = appleIDCredential.email;
    NSString *identityToken = [[NSString alloc] initWithData:appleIDCredential.identityToken encoding:NSUTF8StringEncoding];
    NSString *authorizationCode = [[NSString alloc] initWithData:appleIDCredential.authorizationCode encoding:NSUTF8StringEncoding];
    authResult = [[NSDictionary alloc] initWithObjectsAndKeys:
      user ?: [NSNull null], @"user",
      familyName ?: [NSNull null], @"familyName",
      givenName ?: [NSNull null], @"givenName",
      email ?: [NSNull null], @"email",
      authorizationCode ?: [NSNull null], @"authorizationCode",
      identityToken ?: [NSNull null], @"identityToken",
     nil];
  } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
    ASPasswordCredential *passwordCredential = authorization.credential;
    NSString *user = passwordCredential.user;
    NSString *password = passwordCredential.password;
    authResult = [[NSDictionary alloc] initWithObjectsAndKeys:
     user ?: [NSNull null], @"user",
     password ?: [NSNull null], @"password",
     nil];
  }

  CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:authResult];
  [self.commandDelegate sendPluginResult:result callbackId:self.getCredentialStateCallbackId];
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
  NSString *errorMsg = nil;
  switch (error.code) {
    case ASAuthorizationErrorCanceled:
      errorMsg = @"Cancelled";
      break;
    case ASAuthorizationErrorFailed:
      errorMsg = @"Failed";
      break;
    case ASAuthorizationErrorInvalidResponse:
      errorMsg = @"Invalid";
      break;
    case ASAuthorizationErrorNotHandled:
      errorMsg = @"Not Handled";
      break;
    case ASAuthorizationErrorUnknown:
      errorMsg = @"Unknown";
      break;
  }

  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMsg];
  [self.commandDelegate sendPluginResult:result callbackId:self.getCredentialStateCallbackId];
}

//! Tells the delegate from which window it should present content to the user.
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
  NSLog(@"presentationAnchorForAuthorizationController：%s", __FUNCTION__);
  return self.viewController.view.window;
}

@end
