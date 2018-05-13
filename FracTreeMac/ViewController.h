
#import <Cocoa/Cocoa.h>
#import "FTView.h"
#import "FTConfiguration.h"

@interface ViewController : NSViewController

@property (nonatomic) FTConfiguration *configuration;
@property (weak) IBOutlet FTView *fracTreeView;

@property (weak, nonatomic) IBOutlet NSImageView *anchorImageView;
@property (weak, nonatomic) IBOutlet NSImageView *baseLengthImageView;
@property (weak, nonatomic) IBOutlet NSImageView *angleImageView;
@property (weak) IBOutlet NSSegmentedControl *capControl;
@property (weak) IBOutlet NSSegmentedControl *branchCountControl;

@end

