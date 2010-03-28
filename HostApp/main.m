#import <Cocoa/Cocoa.h>
#import <Python/Python.h>

int main(int argc, char *argv[]) {
    //  Py_Initialize();
    return NSApplicationMain(argc,  (const char **) argv);
    //  Py_Finalize();
}
