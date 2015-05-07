//
//  AXDummyViewController.m
//  AXToggleTitleContainerController
//

#import "AXDummyViewController.h"

@interface AXDummyViewController ()

@end

@implementation AXDummyViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor colorWithRed:rand() % 255 / 255.0
                                              green:rand() % 255 / 255.0
                                               blue:rand() % 255 / 255.0
                                              alpha:1.0];
}

@end
