#import "AppDelegate.h"
#import <Python/Python.h>

@implementation AppDelegate

@synthesize window;
@synthesize textFieldOne;
@synthesize zeplugin_bundle;
@synthesize zeplugin_class;

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSURL *my_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSURL *plugin_url = [[my_url URLByDeletingLastPathComponent]
                         URLByAppendingPathComponent:@"ZePlugin.bundle"];
    zeplugin_bundle = [NSBundle bundleWithURL:plugin_url];

    [zeplugin_bundle load];
    zeplugin_class = [zeplugin_bundle principalClass];
    [zeplugin_class pluginLoaded];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [zeplugin_class pluginWillUnload];
}

@end
