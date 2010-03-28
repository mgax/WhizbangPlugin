#import "PluginApi.h"
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSTextField *textFieldOne;
    NSBundle *zeplugin_bundle;
    Class zeplugin_class;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textFieldOne;
@property (assign) NSBundle *zeplugin_bundle;
@property (assign) Class <WhizbangPlugin> zeplugin_class;

@end
