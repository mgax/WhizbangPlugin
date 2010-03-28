#import "Plugin.h"
#import <Python/Python.h>


@implementation Plugin

+ (void)pluginLoaded {
    Py_Initialize();
    PyRun_SimpleString("print 'plugin loaded'");
}

+ (void)pluginWillUnload {
    PyRun_SimpleString("print 'plugin will unload'");
    Py_Finalize();
}

@end
