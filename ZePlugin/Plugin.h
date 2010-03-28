#import "../HostApp/PluginApi.h"
#import <Cocoa/Cocoa.h>
#import <Python/Python.h>


@protocol PythonLink
- (void)invokeWith:(NSDictionary *)kwargs;
@end


@interface Plugin : NSObject <WhizbangPlugin> {
    PyObject *py_module;
}
+ (void)setPyLink:(NSObject <PythonLink> *)obj;

- (void)_setupPythonEnvironment;
- (void)_handlePythonException;

@end
