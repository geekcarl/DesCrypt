#import "DescryptoPlugin.h"
#if __has_include(<descrypto/descrypto-Swift.h>)
#import <descrypto/descrypto-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "descrypto-Swift.h"
#endif

@implementation DescryptoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDescryptoPlugin registerWithRegistrar:registrar];
}
@end
