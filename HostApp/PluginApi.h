@protocol WhizbangPlugin <NSObject>

+ (NSObject <WhizbangPlugin> *)initializePlugin;
- (void)applicationWillTerminate:(NSNotification *)notification;

@end
