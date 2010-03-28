#import "Plugin.h"
#import <Python/Python.h>


@implementation Plugin

+ (void)pluginLoaded {
    Py_Initialize();
    PyRun_SimpleString("print 'plugin loaded'");
    [self _setupPythonEnvironment];
}

+ (void)pluginWillUnload {
    PyRun_SimpleString("print 'plugin will unload'");
    Py_Finalize();
}

+ (void)_setupPythonEnvironment {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"zeplugin_startup" ofType:@"py"];
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:path];
    PyRun_SimpleString([[fh readDataToEndOfFile] bytes]);
}

@end
