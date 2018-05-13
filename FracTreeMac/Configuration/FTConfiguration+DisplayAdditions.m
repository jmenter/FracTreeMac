
#import "FTConfiguration+DisplayAdditions.h"
#import "CGAdditions.h"

@implementation FTConfiguration (DisplayAdditions)

- (NSString *)anchorDescription;
{
    return [NSString stringWithFormat:@"Anchor Position: %i, %i\n%@", (int)self.anchorPoint.x, (int)self.anchorPoint.y, [self anchorAngleDescription]];
}

- (NSString *)anchorAngleDescription;
{
    return [NSString stringWithFormat:@"Anchor Angle: %0.1f°", RadiansToDegrees(self.anchorAngle)];
}

- (NSString *)baseBranchDescription;
{
    return [NSString stringWithFormat:@"%@\nBase branch angle: %0.1f°", self.baseBranchLengthDescription, RadiansToDegrees(-self.intraBranchAngle)];
}

- (NSString *)baseBranchLengthDescription;
{
    return [NSString stringWithFormat:@"Base Branch Length: %i", (int)self.baseBranchLength];
}

- (NSString *)intraBranchDescription;
{
    return [NSString stringWithFormat:@"Branch length multiplier: %0.2fx\nIntra-branch angle: %0.1f°", self.branchLengthMultiplier, RadiansToDegrees(-self.baseBranchAngle)];
}

@end
