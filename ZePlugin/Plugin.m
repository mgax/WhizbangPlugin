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
    // read setup code from file in bundle
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"zeplugin_startup" ofType:@"py"];
    NSString *src = [NSString stringWithContentsOfFile:path
                                              encoding:NSUTF8StringEncoding
                                                 error:NULL];
    const char *c_src = [src cStringUsingEncoding:NSUTF8StringEncoding];

    // set up new barebones module
    PyObject *py_module = PyImport_AddModule("zeplugin_startup");
    if (py_module == NULL) return [self _handlePythonException];

    PyObject *py_builtins = PyImport_ImportModule("__builtin__");
    if (py_builtins == NULL) return [self _handlePythonException];
    PyModule_AddObject(py_module, "__builtins__", py_builtins);
    Py_DECREF(py_builtins);

    // run the setup code and populate our new module
    PyObject *py_mod_dict = PyModule_GetDict(py_module);
    PyObject *result = PyRun_String(c_src, Py_file_input,
                                    py_mod_dict, py_mod_dict);
    if (result == NULL) return [self _handlePythonException];
    Py_DECREF(result);
}

+ (void)_handlePythonException {
    if (PyErr_Occurred() != NULL) {
        PyErr_PrintEx(0);
        PyErr_Clear();
    }
}

@end
