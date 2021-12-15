#import "PagodaRouterPlugin.h"
#if __has_include(<pagoda_router/pagoda_router-Swift.h>)
#import <pagoda_router/pagoda_router-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pagoda_router-Swift.h"
#endif

@implementation PagodaRouterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPagodaRouterPlugin registerWithRegistrar:registrar];
}
@end
