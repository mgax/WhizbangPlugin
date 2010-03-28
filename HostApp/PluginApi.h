@protocol WhizbangPlugin <NSObject>

+ (NSObject <WhizbangPlugin> *)initializePlugin;
- (void)applicationWillTerminate:(NSNotification *)notification;
- (void)magicRequestedWithText:(NSString *)text;

@end
