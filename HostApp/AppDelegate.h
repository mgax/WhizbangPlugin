#import "PluginApi.h"
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSTextField *textFieldOne;
    NSObject <WhizbangPlugin> *zeplugin;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textFieldOne;

- (IBAction)magicButtonClicked:(id)sender;

@end
