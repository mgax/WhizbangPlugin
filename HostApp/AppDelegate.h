#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSTextField *textFieldOne;
    NSBundle *zeplugin_bundle;
    NSObject *zeplugin;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textFieldOne;
@property (assign) NSBundle *zeplugin_bundle;
@property (assign) NSObject *zeplugin;

@end
