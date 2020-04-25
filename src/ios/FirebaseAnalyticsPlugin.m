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
    if([name isEqualToString:@"signup"]) {
        /*[FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{
            kFIRParameterMethod:[parameters valueForKey:@"method"]
        }];*/
	[FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{}];
    } else if([name isEqualToString:@"tutorialbegin"]) {
        [FIRAnalytics logEventWithName:kFIREventTutorialBegin parameters:@{}];
    } else if([name isEqualToString:@"tutorialcomplete"]) {
        [FIRAnalytics logEventWithName:kFIREventTutorialComplete parameters:@{}];
    } else if([name isEqualToString:@"login"]) {
        /*[FIRAnalytics logEventWithName:kFIREventLogin parameters:@{
            kFIRParameterMethod:[parameters valueForKey:@"method"]
        }];*/
	[FIRAnalytics logEventWithName:kFIREventLogin parameters:@{}];
    } else if([name isEqualToString:@"addtowishlist"]) { 
        [FIRAnalytics logEventWithName:kFIREventAddToWishlist parameters:@{
	    kFIRParameterItemCategory:[parameters valueForKey:@"item_category"],
    	    kFIRParameterItemName:[parameters valueForKey:@"item_name"],
	    kFIRParameterItemLocationID:[parameters valueForKey:@"item_location_id"],
	    kFIRParameterItemID:[parameters valueForKey:@"item_id"],
	    kFIRParameterQuantity:[parameters valueForKey:@"quantity"],
	    @"interaction_pagename":[parameters valueForKey:@"interaction_pagename"]
        }];
    } else if([name isEqualToString:@"addtocart"]) {
	[FIRAnalytics logEventWithName:kFIREventAddToCart parameters:@{
	    kFIRParameterItemCategory:[parameters valueForKey:@"item_category"],
	    kFIRParameterItemName:[parameters valueForKey:@"item_name"],
	    kFIRParameterItemLocationID:[parameters valueForKey:@"item_location_id"],
	    kFIRParameterCurrency:[parameters valueForKey:@"currency"],
	    kFIRParameterValue:[parameters valueForKey:@"value"],
	    kFIRParameterCoupon:[parameters valueForKey:@"coupon"],
	    kFIRParameterItemID:[parameters valueForKey:@"item_id"],
	    kFIRParameterQuantity:[parameters valueForKey:@"quantity"]
        }];
    } else if([name isEqualToString:@"ecommercepurchase"]) {
    	[FIRAnalytics logEventWithName:kFIREventEcommercePurchase parameters:@{
            kFIRParameterCoupon:[parameters valueForKey:@"coupon"],
	    kFIRParameterCurrency:[parameters valueForKey:@"currency"],
	    kFIRParameterValue:[parameters valueForKey:@"value"],
	    kFIRParameterTransactionID:[parameters valueForKey:@"transaction_id"],
	    kFIRParameterLocation:[parameters valueForKey:@"location"],
	    kFIRParameterItemName:[parameters valueForKey:@"item_name"]
        }];
    } else if([name isEqualToString:@"viewitem"]) {  
        [FIRAnalytics logEventWithName:kFIREventViewItem parameters:@{
	    kFIRParameterOrigin:[parameters valueForKey:@"origin"],
	    kFIRParameterItemID:[parameters valueForKey:@"item_id"],
	    kFIRParameterItemName:[parameters valueForKey:@"item_name"],
	    kFIRParameterItemCategory:[parameters valueForKey:@"item_category"],
	    kFIRParameterSearchTerm:[parameters valueForKey:@"search_term"]
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
