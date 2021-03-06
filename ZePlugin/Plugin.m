#import "Plugin.h"


@implementation Plugin

static NSObject <PythonLink> *pylink;
+ (void)setPyLink:(NSObject <PythonLink> *)obj {
    pylink = [obj retain];
}

+ (NSObject <WhizbangPlugin> *)initializePlugin {
    Plugin *instance = [Plugin alloc];
    [instance _setupPythonEnvironment];
    return [instance autorelease];
}

- (void)_setupPythonEnvironment {
    Py_Initialize();

    // read setup code from file in bundle
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"zeplugin_startup" ofType:@"py"];
    NSString *src = [NSString stringWithContentsOfFile:path
                                              encoding:NSUTF8StringEncoding
                                                 error:NULL];
    const char *c_src = [src UTF8String];

    // set up new barebones module
    py_module = PyImport_AddModule("zeplugin_startup");
    if (py_module == NULL) return [self _handlePythonException];

    PyObject *py_builtins = PyImport_ImportModule("__builtin__");
    if (py_builtins == NULL) return [self _handlePythonException];
    PyModule_AddObject(py_module, "__builtins__", py_builtins);
    Py_DECREF(py_builtins);

    // run the setup code and populate our new module
    const char* bundle_path = [[bundle bundlePath] UTF8String];
    PyObject *py_mod_dict = PyModule_GetDict(py_module);
    PyDict_SetItemString(py_mod_dict, "bundle_path",
                         PyString_FromString(bundle_path));
    PyObject *result = PyRun_String(c_src, Py_file_input,
                                    py_mod_dict, py_mod_dict);
    if (result == NULL) return [self _handlePythonException];
    Py_DECREF(result);
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    PyRun_SimpleString("print 'plugin unloading'");
    Py_Finalize();
}

- (void)_handlePythonException {
    if (PyErr_Occurred() != NULL) {
        PyErr_PrintEx(0);
        PyErr_Clear();
    }
}

- (void)magicRequestedWithText:(NSString *)text {
    NSMutableDictionary *kwargs = [NSMutableDictionary dictionary];
    [kwargs setValue:@"magic_requested" forKey:@"invocation_name"];
    [kwargs setValue:text forKey:@"text"];
    [pylink invokeWith:kwargs];
}

@end
