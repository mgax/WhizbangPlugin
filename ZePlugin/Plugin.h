#import "../HostApp/PluginApi.h"
#import <Cocoa/Cocoa.h>
#import <Python/Python.h>


@interface Plugin : NSObject <WhizbangPlugin> {
    PyObject *py_module;
}
- (void)_setupPythonEnvironment;
- (void)_handlePythonException;

@end
