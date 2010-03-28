@protocol WhizbangPlugin <NSObject>

+ (void)pluginLoaded;
+ (void)pluginWillUnload;

@end
