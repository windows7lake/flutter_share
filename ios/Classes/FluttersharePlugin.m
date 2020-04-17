#import "FlutterSharePlugin.h"
#if __has_include(<fluttershare/fluttershare-Swift.h>)
#import <fluttershare/fluttershare-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttershare-Swift.h"
#endif

@implementation FlutterSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluttersharePlugin registerWithRegistrar:registrar];
}
@end
