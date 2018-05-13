
#import "FTConfiguration.h"

@implementation FTConfiguration

int RandomIntFromZeroTo(int maxInclusive) {
    return arc4random_uniform(maxInclusive + 1);
}

float RandomFloatFromZeroTo(float maxInclusive) {
    return drand48() * maxInclusive;
}

+ (instancetype)randomConfiguration;
{
    FTConfiguration *configuation = FTConfiguration.new;
    configuation.baseBranchLength = RandomFloatFromZeroTo(200.f);
    configuation.baseBranchWidth = RandomFloatFromZeroTo(10.f);
    configuation.baseBranchAngle = RandomFloatFromZeroTo(M_PI * 2.f);
    configuation.baseBranchCount = RandomIntFromZeroTo(4) + 1;
    
    configuation.branchLengthMultiplier = RandomFloatFromZeroTo(2.f);
    configuation.branchWidthMultiplier = RandomFloatFromZeroTo(2.f);
    configuation.branchTransparencyMultiplier = RandomFloatFromZeroTo(1.f);
    configuation.intraBranchAngle = RandomFloatFromZeroTo(M_PI * 2.f);
    
    configuation.lineCap = RandomIntFromZeroTo(2);
    configuation.iterationCount = RandomIntFromZeroTo(9);
    
    configuation.anchorPoint = CGPointMake(800 / 2.f,
                                           600 / 2.f);
    configuation.anchorAngle = RandomFloatFromZeroTo(M_PI * 2.f);
    configuation.baseHue = RandomFloatFromZeroTo(1.f);
    
    return configuation;
}

- (instancetype)init;
{
    if (!(self = [super init])) { return nil; }
    
    self.baseBranchLength = 100.f;
    self.baseBranchWidth = 3.f;
    self.baseBranchAngle = -0.5;
    self.baseBranchCount = 3.f;
    
    self.branchLengthMultiplier = 0.6f;
    self.branchWidthMultiplier = 1.2f;
    self.branchTransparencyMultiplier = 0.6f;
    self.intraBranchAngle = 0.4f;
    
    self.lineCap = kCGLineCapRound;
    self.iterationCount = 6;
    
    self.anchorPoint = CGPointMake(175, 350);
    self.anchorAngle = 3.1;
    self.baseHue = 1.f;
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    if (!(self = [self init])) { return nil; }
    
    self.baseBranchLength = [aDecoder decodeFloatForKey:@"baseBranchLength"];
    self.baseBranchWidth = [aDecoder decodeFloatForKey:@"baseBranchWidth"];
    self.baseBranchAngle = [aDecoder decodeFloatForKey:@"baseBranchAngle"];
    self.baseBranchCount = [aDecoder decodeIntegerForKey:@"baseBranchCount"];
    
    self.branchLengthMultiplier = [aDecoder decodeFloatForKey:@"branchLengthMultiplier"];
    self.branchWidthMultiplier = [aDecoder decodeFloatForKey:@"branchWidthMultiplier"];
    self.branchTransparencyMultiplier = [aDecoder decodeFloatForKey:@"branchTransparencyMultiplier"];
    self.intraBranchAngle = [aDecoder decodeFloatForKey:@"intraBranchAngle"];
    
    self.lineCap = (CGLineCap)[aDecoder decodeIntegerForKey:@"lineCap"];
    self.iterationCount = [aDecoder decodeIntegerForKey:@"iterationCount"];
    self.anchorPoint = [aDecoder decodePointForKey:@"anchorPoint"];
    self.anchorAngle = [aDecoder decodeFloatForKey:@"anchorAngle"];
    self.baseHue = [aDecoder decodeFloatForKey:@"baseHue"];
    self.previewImage = [aDecoder decodeObjectForKey:@"previewImage"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeFloat:self.baseBranchLength forKey:@"baseBranchLength"];
    [aCoder encodeFloat:self.baseBranchWidth forKey:@"baseBranchWidth"];
    [aCoder encodeFloat:self.baseBranchAngle forKey:@"baseBranchAngle"];
    [aCoder encodeInteger:self.baseBranchCount forKey:@"baseBranchCount"];
    
    [aCoder encodeFloat:self.branchLengthMultiplier forKey:@"branchLengthMultiplier"];
    [aCoder encodeFloat:self.branchWidthMultiplier forKey:@"branchWidthMultiplier"];
    [aCoder encodeFloat:self.branchTransparencyMultiplier forKey:@"branchTransparencyMultiplier"];
    [aCoder encodeFloat:self.intraBranchAngle forKey:@"intraBranchAngle"];

    [aCoder encodeInteger:self.lineCap forKey:@"lineCap"];
    [aCoder encodeInteger:self.iterationCount forKey:@"iterationCount"];
    [aCoder encodePoint:self.anchorPoint forKey:@"anchorPoint"];
    [aCoder encodeFloat:self.anchorAngle forKey:@"anchorAngle"];
    [aCoder encodeFloat:self.baseHue forKey:@"baseHue"];
    [aCoder encodeObject:self.previewImage forKey:@"previewImage"];
}

- (instancetype)copyWithZone:(NSZone *)zone;
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end
