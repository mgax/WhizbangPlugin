#import "AppDelegate.h"
#import <Python/Python.h>

//#import <CoreFoundation/CoreFoundation.h>

@implementation AppDelegate

@synthesize window;
@synthesize textFieldOne;
@synthesize zeplugin_bundle;
@synthesize zeplugin;

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    //letters_py_bundle = [NSBundle bundleWithIdentifier:@"ro.grep.whizbang.ZePlugin"];
    //NSLog(@"bundle: %p", letters_py_bundle);
    NSURL *my_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSURL *plugin_url = [[my_url URLByDeletingLastPathComponent]
                         URLByAppendingPathComponent:@"ZePlugin.bundle"];
    zeplugin_bundle = [NSBundle bundleWithURL:plugin_url];

    [zeplugin_bundle load];
    //NSLog(@"plugin info: %@", [self.zeplugin_bundle infoDictionary]);
    Class zeplugin_class = [zeplugin_bundle principalClass];
    NSLog(@"plugin class: %@", zeplugin_class);
    zeplugin = [zeplugin_class alloc];
    NSLog(@"plugin: %@", zeplugin);
    [zeplugin speak];


//    [self.textFieldOne setStringValue: @"Hello world!"];
//    PyRun_SimpleStringFlags("def p(n):\n  print 13+n\n\np(2)", NULL);
}

- (void)applicationWillTerminate:(NSNotification *)notification {
}

@end
