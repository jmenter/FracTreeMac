
#import "FTView.h"
#import "FTConfiguration.h"

@interface FTView ()

@property (nonatomic) NSUInteger renderedLineCount;

@property (nonatomic) CGFloat baseHue;
@property (nonatomic) CGFloat baseSat;
@property (nonatomic) CGFloat baseBrt;

@property (nonatomic) CGFloat hueMultiplier;
@property (nonatomic) CGFloat satMultiplier;
@property (nonatomic) CGFloat brtMultiplier;

@property (nonatomic) NSDate *startTime;
@property (nonatomic) BOOL didExceedTimeThreshold;
@end

@implementation FTView

- (instancetype)init; { if (!(self = [super init])) return nil; return [self commonInit]; }
- (instancetype)initWithCoder:(NSCoder *)aDecoder; { if (!(self = [super initWithCoder:aDecoder])) return nil; return [self commonInit]; }
- (instancetype)initWithFrame:(CGRect)frame; { if (!(self = [super initWithFrame:frame])) return nil; return [self commonInit]; }

- (instancetype)commonInit;
{
    self.baseHue = 1.f;
    self.baseSat = 0.6f;
    self.baseBrt = 1.f;
    return self;
}

- (void)drawRect:(NSRect)dirtyRect;
{
    CGContextRef context = NSGraphicsContext.currentContext.CGContext;
    
    self.startTime = NSDate.date;
    self.didExceedTimeThreshold = NO;
    self.renderedLineCount = 0;
    self.hueMultiplier = 1.f - (1.f / self.configuration.iterationCount);
    CGContextSaveGState(context);
    CGContextSetLineCap(context, self.configuration.lineCap);
    CGContextTranslateCTM(context, self.configuration.anchorPoint.x,
                          self.configuration.anchorPoint.y);
    CGContextRotateCTM(context, -self.configuration.anchorAngle + self.configuration.baseBranchAngle);
    [self drawBranchInContext:context
                       length:self.configuration.baseBranchLength
                        width:self.configuration.baseBranchWidth
                        angle:self.configuration.baseBranchAngle
                   intraAngle:self.configuration.intraBranchAngle
                    baseCount:self.configuration.baseBranchCount
                 currentCount:0
               iterationCount:self.configuration.iterationCount
                        alpha:1.f
                          hue:self.configuration.baseHue];
    
    CGContextRestoreGState(context);
    [self.renderInfoDelegate renderInfo:self.renderedLineCount
                           timeInterval:-self.startTime.timeIntervalSinceNow
                 didExceedTimeThreshold:self.didExceedTimeThreshold];
}

- (void)drawBranchInContext:(CGContextRef)context
                     length:(CGFloat)length
                      width:(CGFloat)width
                      angle:(CGFloat)angle
                 intraAngle:(CGFloat)intraAngle
                  baseCount:(NSUInteger)baseCount
               currentCount:(NSUInteger)currentCount
             iterationCount:(NSUInteger)iterationCount
                      alpha:(CGFloat)alpha
                        hue:(CGFloat)hue;
{
    if (currentCount > iterationCount || -self.startTime.timeIntervalSinceNow > 0.5f) {
        if (-self.startTime.timeIntervalSinceNow > 0.5f) {
            self.didExceedTimeThreshold = YES;
        }
        return;
    }
    
    CGFloat halfTotal = ((baseCount - 1) * intraAngle) / 2.0f;
    CGContextRotateCTM(context, -halfTotal - self.configuration.baseBranchAngle);
    for (int i = 0; i < baseCount; i++) {
        CGContextMoveToPoint(context, 0.f, 0.f);
        CGContextAddLineToPoint(context, 0.f, length);
        
        CGContextSetStrokeColorWithColor(context, [NSColor colorWithHue:hue saturation:self.baseSat * ((float)(i + 1) / (float)baseCount) brightness:self.baseBrt alpha:alpha].CGColor);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
        self.renderedLineCount++;
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.f, length);
        
        [self drawBranchInContext:context
                           length:length * self.configuration.branchLengthMultiplier
                            width:width * self.configuration.branchWidthMultiplier
                            angle:angle
                       intraAngle:intraAngle
                        baseCount:baseCount
                     currentCount:currentCount + 1
                   iterationCount:iterationCount
                            alpha:alpha * self.configuration.branchTransparencyMultiplier
                              hue:hue * self.hueMultiplier];
        
        CGContextRestoreGState(context);
        CGContextRotateCTM(context, intraAngle);
    }
}

@end






