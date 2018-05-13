
#import <Foundation/Foundation.h>

@class FTConfiguration;

@interface FTConfigurationManager : NSObject

+ (instancetype)shared;

- (FTConfiguration *)configurationAtIndex:(NSUInteger)index;
- (NSUInteger)configurationCount;

- (void)addConfiguration:(FTConfiguration *)configuration;
- (void)removeConfigurationsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths;

@end
