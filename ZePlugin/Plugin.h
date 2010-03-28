#import "../HostApp/PluginApi.h"
#import <Cocoa/Cocoa.h>


@interface Plugin : NSObject <WhizbangPlugin> {
}
+ (void)_setupPythonEnvironment;
+ (void)_handlePythonException;

@end
