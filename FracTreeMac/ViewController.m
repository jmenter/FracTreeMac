
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.configuration = FTConfiguration.new;
    self.fracTreeView.configuration = self.configuration;
}

@end
