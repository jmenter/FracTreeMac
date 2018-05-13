
#import "ViewController.h"
#import "NSImageView+Extras.h"
#import "CGAdditions.h"

@implementation NSView (Center)

- (void)setCenter:(CGPoint)center;
{
    self.frame = NSMakeRect(center.x - self.frame.size.width / 2.0, center.y - self.frame.size.height / 2.0, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)center;
{
    return CGPointMake(self.frame.origin.x + self.frame.size.width / 2.0, self.frame.origin.y + self.frame.size.height / 2.0);
}

@end

typedef NS_ENUM(NSUInteger, MousePhase) {
    MousePhaseBegan,
    MousePhaseMoved,
    MousePhaseEnded,
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.anchorImageView.tintColor = [NSColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0];
    self.baseLengthImageView.tintColor = [NSColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];
    self.angleImageView.tintColor = [NSColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:1.0];

    
    self.view.layer.backgroundColor = NSColor.blackColor.CGColor;
    self.configuration = FTConfiguration.new;
    self.fracTreeView.configuration = self.configuration;
    
    self.capControl.selectedSegment = self.configuration.lineCap;
    self.branchCountControl.selectedSegment = self.configuration.baseBranchCount - 1;

}

- (IBAction)valueChanged:(id)sender;
{
    [self syncTree];
}

- (void)mouseDown:(NSEvent *)event;
{
    [self handleMousePhase:MousePhaseBegan location:event.locationInWindow];
}

- (void)mouseDragged:(NSEvent *)event;
{
    [self handleMousePhase:MousePhaseMoved location:event.locationInWindow];
}

- (void)mouseUp:(NSEvent *)event;
{
    [self handleMousePhase:MousePhaseEnded location:event.locationInWindow];
}

- (void)handleMousePhase:(MousePhase)mousePhase location:(NSPoint)location;
{
    // touch related
    static NSView *initialTouchView;
    static CGPoint initialTouchPoint;
    
    // tree related
    static CGPoint initialAnchor;
    static CGFloat initialBaseBranchLength;
    static CGFloat initialBaseBranchAngle;
    static CGFloat initlalIntraBranchAngle;
    static CGFloat initialBaseThickness;
    
    NSView *touchView = NSPointInRect(location, self.anchorImageView.frame) ? self.anchorImageView :
                        NSPointInRect(location, self.baseLengthImageView.frame) ? self.baseLengthImageView :
                        NSPointInRect(location, self.angleImageView.frame) ? self.angleImageView : self.fracTreeView;

    if (mousePhase == MousePhaseBegan) {
        initialTouchView = NSPointInRect(location, self.anchorImageView.frame) ? self.anchorImageView :
        NSPointInRect(location, self.baseLengthImageView.frame) ? self.baseLengthImageView :
        NSPointInRect(location, self.angleImageView.frame) ? self.angleImageView : self.fracTreeView;
        initialTouchPoint = location;
        
        initialAnchor = self.configuration.anchorPoint;
        initialBaseBranchLength = self.configuration.baseBranchLength;
        initialBaseBranchAngle = self.configuration.baseBranchAngle;
        initlalIntraBranchAngle = self.configuration.intraBranchAngle;
        initialBaseThickness = self.configuration.baseBranchWidth;
        
//        self.anchorImageView.highlighted = (touch.view == self.anchorImageView);
//        self.baseLengthImageView.highlighted = (touch.view == self.baseLengthImageView);
//        self.angleImageView.highlighted = (touch.view == self.angleImageView);
        
//        if (touch.view != self.fracTreeView) {
//            self.infoLabel.center = [self occlusionOffsetPointForPoint:initialTouchPoint];
//            if (touch.view == self.anchorImageView) {
//                self.infoLabel.text = self.configuration.anchorDescription;
//            } else if (touch.view == self.baseLengthImageView) {
//                self.infoLabel.text = self.configuration.baseBranchDescription;
//            } else if (touch.view == self.angleImageView) {
//                self.infoLabel.text = self.configuration.intraBranchDescription;
//            } else {
//                self.infoLabel.text = nil;
//            }
//            [self.infoLabel fadeIn:kFadeInTimeInterval];
//        }
    }
    
    if (mousePhase == MousePhaseMoved) {
        initialTouchView = nil;
//        self.infoLabel.center = [self occlusionOffsetPointForPoint:[touch locationInView:self.view]];
        CGPoint touchDelta = CGPointSubtractPoints(location, initialTouchPoint);
        if (touchView == self.fracTreeView || touchView == self.anchorImageView) {
            self.configuration.anchorPoint = CGPointAddPoints(initialAnchor, touchDelta);
            if (touchView == self.anchorImageView) {
//                self.infoLabel.text = self.configuration.anchorDescription;
            }
        } else if (touchView == self.baseLengthImageView) {
            
            self.configuration.baseBranchLength = CGFloatDistanceBetweenPoints(self.configuration.anchorPoint, location);
            self.configuration.intraBranchAngle = CGPointATan2(location, self.configuration.anchorPoint) - self.configuration.anchorAngle ;
            
//            self.infoLabel.text = self.configuration.baseBranchDescription;
            
        } else if (touchView == self.angleImageView) {
            
            CGPoint baseLengthPoint = CGPointMake(self.configuration.baseBranchLength * sin(self.configuration.intraBranchAngle + self.configuration.anchorAngle),
                                                  self.configuration.baseBranchLength * cos(self.configuration.intraBranchAngle + self.configuration.anchorAngle));
            CGPoint lengthRatioPoint = CGPointAddPoints(self.configuration.anchorPoint, baseLengthPoint);
            CGFloat ratioDistanceLength = CGFloatDistanceBetweenPoints(lengthRatioPoint, location);
            self.configuration.branchLengthMultiplier = ratioDistanceLength /self.configuration.baseBranchLength ;
            self.configuration.baseBranchAngle = CGPointATan2(location, lengthRatioPoint) - self.configuration.intraBranchAngle  - self.configuration.anchorAngle;
//            self.infoLabel.text = self.configuration.intraBranchDescription;
        }
    }
    if (mousePhase == MousePhaseEnded) {
//        self.anchorImageView.highlighted =
//        self.angleImageView.highlighted =
//        self.baseLengthImageView.highlighted = NO;
//        [self.infoLabel fadeOut:kFadeoutTimeInterval];
//
//        if (initialTouchView == self.anchorImageView) {
//            [self presentAnchorEditor];
//        } else if (initialTouchView == self.baseLengthImageView) {
//            [self presentBaseLengthEditor];
//        } else if (initialTouchView == self.angleImageView) {
//            [self presentAngleEditor];
//        }
        return;
    }
    [self syncTree];

}
    
    - (void)syncTree;
    {
        // set UI state
//        self.alphaSlider.baseHue =
//        self.weightRatioSlider.baseHue = self.hueSlider.value;
        // set configuration based on ui
//        self.configuration.branchTransparencyMultiplier = self.alphaSlider.value;
        self.configuration.baseBranchCount = self.branchCountControl.selectedSegment + 1;
//        self.configuration.iterationCount = roundf(self.iterationCountControl.value);
        self.configuration.lineCap = (CGLineCap)self.capControl.selectedSegment;
//        self.configuration.baseHue = self.hueSlider.value;
//        self.configuration.branchWidthMultiplier = self.weightRatioSlider.value;
        
        // set ui based on configuration
        
        // anchor
        self.anchorImageView.center = self.configuration.anchorPoint;
//        [self.anchorImageView alignFrameToDevicePixels];
        
        // base length / anchor angle
        CGPoint baseLengthPoint = CGPointMake(self.configuration.baseBranchLength * sin(self.configuration.intraBranchAngle + self.configuration.anchorAngle),
                                              self.configuration.baseBranchLength * cos(self.configuration.intraBranchAngle + self.configuration.anchorAngle));
        self.baseLengthImageView.center = CGPointAddPoints(self.configuration.anchorPoint, baseLengthPoint);
//        [self.baseLengthImageView alignFrameToDevicePixels];
        
        // length ratio
        CGFloat ratioLength = self.configuration.baseBranchLength * self.configuration.branchLengthMultiplier;
        CGPoint lengthRatioPoint = CGPointMake(ratioLength * sin(self.configuration.intraBranchAngle + self.configuration.anchorAngle + self.configuration.baseBranchAngle),
                                               ratioLength * cos(self.configuration.intraBranchAngle + self.configuration.anchorAngle + self.configuration.baseBranchAngle));
        CGPoint alignedBaseLength = CGPointAddPoints(self.configuration.anchorPoint, baseLengthPoint);
        self.angleImageView.center = CGPointAddPoints(alignedBaseLength, lengthRatioPoint);
//        [self.angleImageView alignFrameToDevicePixels];
        [self.fracTreeView setNeedsDisplay: YES];
    }

@end
