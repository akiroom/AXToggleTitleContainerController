//
//  AXAppDelegate.m
//  AXToggleTitleContainerController
//

#import "AXAppDelegate.h"
#import <AXToggleTitleContainerController/AXToggleTitleContainerController.h>
#import "AXSampleViewController.h"

@implementation AXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Create sample view controllers
  NSArray *sampleViewControllers = [self createSampleViewControllers];
  
  // Create ToggleTitleContainerController
  AXToggleTitleContainerController *toggleContainerCon =
  [[AXToggleTitleContainerController alloc] initWithTogglableViewControllers:sampleViewControllers];
  // * You can change ToggleButton's TextColor
  toggleContainerCon.titleToggleButton.tintColor = [UIColor redColor];
  // * You can change SubviewList's BackgroundColor.
  toggleContainerCon.listViewController.snapshotTintColor = [UIColor redColor];
  
  // Create New Window with Navigation Controller
  UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  window.rootViewController = [[UINavigationController alloc]
                               initWithRootViewController:toggleContainerCon];
  [window makeKeyAndVisible];
  self.window = window;
  return YES;
}

- (NSArray *)createSampleViewControllers
{
  UIBarButtonItem *item;

  // Normal View Controller
  AXSampleViewController *sampleViewCon1; {
    sampleViewCon1 = [[AXSampleViewController alloc] init];
    sampleViewCon1.title = @"Main";
  }
  
  // View Controller with Left Bar Button Item
  AXSampleViewController *sampleViewCon2; {
    sampleViewCon2 = [[AXSampleViewController alloc] init];
    sampleViewCon2.title = @"Articles";
    item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                         target:nil action:NULL];
    sampleViewCon2.navigationItem.leftBarButtonItem = item;
  }
  
  // View Controller with Right Bar Button Item
  AXSampleViewController *sampleViewCon3; {
    sampleViewCon3 = [[AXSampleViewController alloc] init];
    sampleViewCon3.title = @"Users";
    item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                         target:nil action:NULL];
    sampleViewCon3.navigationItem.rightBarButtonItem = item;
  }
  
  // View Controller with Left and Right Bar Button Item
  AXSampleViewController *sampleViewCon4; {
    sampleViewCon4 = [[AXSampleViewController alloc] init];
    sampleViewCon4.title = @"Super Long of the Long Awesome Title";
    sampleViewCon4.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                  target:nil action:NULL];
    sampleViewCon4.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                  target:nil action:NULL];
  }
  
  // Setup Toggle Tittle Container Controller
  NSArray *viewControllers =
  @[
    sampleViewCon1, sampleViewCon2, sampleViewCon3, sampleViewCon4
    ];

  return viewControllers;
}

@end
