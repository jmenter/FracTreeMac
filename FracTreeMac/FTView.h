
#import <AppKit/AppKit.h>

@class FTConfiguration;

@protocol RenderInfoDelegate <NSObject>

@optional
-(void)renderInfo:(NSUInteger)lineCount
     timeInterval:(NSTimeInterval)timeInterval didExceedTimeThreshold:(BOOL)didExceed;
@end

@interface FTView : NSView

@property (nonatomic, weak) FTConfiguration *configuration;
@property (nonatomic, weak) IBOutlet id<RenderInfoDelegate> renderInfoDelegate;

@end
