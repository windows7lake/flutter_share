#import "FluttersharePlugin.h"
#import "Share/ShareHelper.h"
#import "Share/ShareModel.h"
//#if __has_include(<fluttershare/fluttershare-Swift.h>)
//#import <fluttershare/fluttershare-Swift.h>
//#else
//// Support project import fallback if the generated compatibility header
//// is not copied when this plugin is created as a library.
//// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
//#import "fluttershare-Swift.h"
//#endif

@implementation FluttersharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  //[SwiftFluttersharePlugin registerWithRegistrar:registrar];
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"fluttershare"
              binaryMessenger:[registrar messenger]];
    FluttersharePlugin* instance = [[FluttersharePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

    //result(call.method);
    NSLog(@"%@", call.arguments);
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {

      ShareModel * model = [[ShareModel alloc] initWithParams:call.arguments];
      NSString * platform = call.arguments[@"platform"];
      //[[ShareHelper new] shareToPlatformType:@"line" withContent: model result: result];
      //[[ShareHelper new] shareToPlatformType:@"facebook" withContent: model result: result];
      if([@"SharePlatform.Facebook" isEqualToString:platform]){
          [[ShareHelper new] shareToPlatformType:@"facebook" withContent: model result: result];
      } else {
          [[ShareHelper new] shareToPlatformType:@"line" withContent: model result: result];
      }

  }
//  else if ([@"shareToFBPlatform" isEqualToString:call.method]) {
//      NSDictionary *arguments = [call arguments];
//      NSString * shareContent = arguments[@"shareContent"];
//      NSString * shareUrl = arguments[@"shareUrl"];
//      [ShareHelper shareToPlatformType:SLServiceTypeFacebook withContent:shareContent withShareUrl:shareUrl];
//      result(arguments[""]);
//  }
//  else if ([@"shareToTwitterPlatform" isEqualToString:call.method]) {
//      NSDictionary *arguments = [call arguments];
//      NSString * shareContent = arguments[@"shareContent"];
//      NSString * shareUrl = arguments[@"shareUrl"];
//      [ShareHelper shareToPlatformType:SLServiceTypeTwitter withContent:shareContent withShareUrl:shareUrl];
//      result(nil);
//  }
//  else {
//    result(FlutterMethodNotImplemented);
//  }
}

@end
