
#import "FTConfigurationManager.h"
#import "FTConfiguration.h"

@interface FTConfigurationManager ()
@property (nonatomic, strong) NSMutableArray <FTConfiguration *> *configurations;
@end

static  NSString *kConfigurationsKey = @"configurations";

@implementation FTConfigurationManager

+ (instancetype)shared
{
    static dispatch_once_t once;
    static id shared;
    dispatch_once(&once, ^{ shared = self.new; });
    return shared;
}

- (instancetype)init;
{
    if (!(self = [super init])) { return nil; }
    
    NSData *configurationsData = [NSUserDefaults.standardUserDefaults objectForKey:kConfigurationsKey];
    if (!configurationsData) {
        configurationsData = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"defaultConfigurations" ofType:nil]];
        [NSUserDefaults.standardUserDefaults setObject:configurationsData forKey:kConfigurationsKey];
    }
    self.configurations = [[NSKeyedUnarchiver unarchiveObjectWithData:configurationsData] mutableCopy] ?: NSMutableArray.new;
    
    return self;
}

- (FTConfiguration *)configurationAtIndex:(NSUInteger)index;
{
    return self.configurations[index];
}

- (NSUInteger)configurationCount;
{
    return self.configurations.count;
}

- (void)addConfiguration:(FTConfiguration *)configuration;
{
    [self.configurations addObject:configuration.copy];
    [self save];
}

- (void)removeConfigurationsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths;
{
    NSMutableIndexSet *indexSet = NSMutableIndexSet.new;
//    for (NSIndexPath *indexPath in indexPaths) {
//        [indexSet addIndex:indexPath.row];
//    }
    [self.configurations removeObjectsAtIndexes:indexSet];
    [self save];
}

- (void)save;
{
    NSData *configurationsData = [NSKeyedArchiver archivedDataWithRootObject:self.configurations];
    [NSUserDefaults.standardUserDefaults setObject:configurationsData forKey:kConfigurationsKey];
}

@end
