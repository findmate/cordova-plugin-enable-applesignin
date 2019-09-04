//
//  AppleSignIn.h
//  TestApp
//
//  Created by Zoltan Magyar on 2019. 09. 04..
//

#import <Cordova/CDV.h>
#import <AuthenticationServices/AuthenticationServices.h>

#ifndef AppleSignIn_h
#define AppleSignIn_h

@interface AppleSignIn : CDVPlugin {
  // Member variables go here.
}

@property (nonatomic, strong) NSString* getCredentialStateCallbackId;

- (void)isAvailable:(CDVInvokedUrlCommand*)command;
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0));
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0));
- (void)getCredentialState:(CDVInvokedUrlCommand*)command;
@end

#endif /* AppleSignIn_h */
