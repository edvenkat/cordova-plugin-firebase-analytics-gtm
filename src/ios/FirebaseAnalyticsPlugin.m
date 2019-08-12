#import "FirebaseAnalyticsPlugin.h"
@import Firebase;
static NSString *const kFIRParameterMethod = @"method";

@implementation FirebaseAnalyticsPlugin

- (void)pluginInitialize {
    NSLog(@"Starting Firebase Analytics plugin");

    [FIROptions defaultOptions].deepLinkURLScheme = [FIROptions defaultOptions].bundleID;

    if(![FIRApp defaultApp]) {
        [FIRApp configure];
    }
}

- (void)logEvent:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex:0];
    NSDictionary* parameters = [command.arguments objectAtIndex:1];
    NSString* method = @"email";
    //kFIRParameterMethod 
    //[FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{kFIRParameterSignUpMethod: method}];
   //  [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{kFIRParameterMethod: method}];
    //[FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{kFIRParameterMethod: method}];
    /*
    [FIRAnalytics logEventWithName:kFIREventSelectContent parameters:@{
        kFIRParameterItemID:@"some_item_id",
        kFIRParameterContentType:@"some_content_type"
    }];
    */
    //[FIRAnalytics logEventWithName:name parameters:parameters];
    if([name isEqualToString:@"sign_up"]) {
        [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{
            kFIRParameterSignUpMethod: [parameters valueForKey:@"method"]
        }];
    } else if([name isEqualToString:@"login"]) {
        [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{
            kFIRParameterMethod: [parameters valueForKey:@"method"]
        }];
    } else {
        [FIRAnalytics logEventWithName:name parameters:parameters];
    }

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUserId:(CDVInvokedUrlCommand *)command {
    NSString* id = [command.arguments objectAtIndex:0];

    [FIRAnalytics setUserID:id];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUserProperty:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];

    [FIRAnalytics setUserPropertyString:value forName:name];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setEnabled:(CDVInvokedUrlCommand *)command {
    bool enabled = [[command.arguments objectAtIndex:0] boolValue];

    [[FIRAnalyticsConfiguration sharedInstance] setAnalyticsCollectionEnabled:enabled];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setCurrentScreen:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex:0];

    [FIRAnalytics setScreenName:name screenClass:nil];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
