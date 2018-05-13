
#import <Foundation/Foundation.h>

@interface FTConfiguration : NSObject <NSCoding, NSCopying>

@property (nonatomic) CGFloat baseBranchLength;
@property (nonatomic) CGFloat baseBranchWidth;
@property (nonatomic) CGFloat baseBranchAngle;
@property (nonatomic) NSUInteger baseBranchCount;

@property (nonatomic) CGFloat branchLengthMultiplier;
@property (nonatomic) CGFloat branchWidthMultiplier;
@property (nonatomic) CGFloat branchTransparencyMultiplier;
@property (nonatomic) CGFloat intraBranchAngle;

@property (nonatomic) CGLineCap lineCap;
@property (nonatomic) NSUInteger iterationCount;

@property (nonatomic) CGPoint anchorPoint;
@property (nonatomic) CGFloat anchorAngle;
@property (nonatomic) CGFloat baseHue;

@property (nonatomic) NSImage *previewImage;

+ (instancetype)randomConfiguration;

@end
