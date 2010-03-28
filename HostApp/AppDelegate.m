#import "AppDelegate.h"
#import <Python/Python.h>

@implementation AppDelegate

@synthesize window;
@synthesize textFieldOne;

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSURL *my_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSURL *plugin_url = [[my_url URLByDeletingLastPathComponent]
                         URLByAppendingPathComponent:@"ZePlugin.bundle"];
    NSBundle *zeplugin_bundle = [NSBundle bundleWithURL:plugin_url];
    [zeplugin_bundle load];
    Class <WhizbangPlugin> zeplugin_class = [zeplugin_bundle principalClass];
    zeplugin = [[zeplugin_class initializePlugin] retain];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [zeplugin applicationWillTerminate: notification];
    [zeplugin release];
}

- (IBAction)magicButtonClicked:(id)sender {
    [zeplugin magicRequestedWithText: [textFieldOne stringValue]];
}

@end
