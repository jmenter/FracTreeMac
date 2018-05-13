
#import <Cocoa/Cocoa.h>
#import "FTView.h"
#import "FTConfiguration.h"

@interface ViewController : NSViewController

@property (nonatomic) FTConfiguration *configuration;
@property (weak) IBOutlet FTView *fracTreeView;

@end

