
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = NSColor.blackColor.CGColor;
    self.configuration = FTConfiguration.new;
    self.fracTreeView.configuration = self.configuration;
}

@end
