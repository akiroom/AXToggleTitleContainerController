//
//  AXAppDelegate.m
//  AXToggleTitleContainerController
//

#import "AXAppDelegate.h"
#import <AXToggleTitleContainerController/AXToggleTitleContainerController.h>
#import "AXDummyViewController.h"

@implementation AXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  UIBarButtonItem *item;
  
  // Normal View Controller
  AXDummyViewController *dummyViewCon1 = [[AXDummyViewController alloc] init];
  dummyViewCon1.title = @"Main";

  // View Controller with Left Bar Button Item
  AXDummyViewController *dummyViewCon2 = [[AXDummyViewController alloc] init];
  dummyViewCon2.title = @"Articles";
  item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                       target:nil action:NULL];
  dummyViewCon2.navigationItem.leftBarButtonItem = item;

  // View Controller with Right Bar Button Item
  AXDummyViewController *dummyViewCon3 = [[AXDummyViewController alloc] init];
  dummyViewCon3.title = @"Users";
  item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                       target:nil action:NULL];
  dummyViewCon3.navigationItem.rightBarButtonItem = item;
  
  // View Controller with Left and Right Bar Button Item
  AXDummyViewController *dummyViewCon4 = [[AXDummyViewController alloc] init];
  dummyViewCon4.title = @"Super Long of the Long Awesome Title";
  dummyViewCon4.navigationItem.leftBarButtonItem =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                target:nil action:NULL];
  dummyViewCon4.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                target:nil action:NULL];
  // Setup Toggle Tittle Container Controller
  NSArray *viewControllers =
  @[
    dummyViewCon1, dummyViewCon2, dummyViewCon3, dummyViewCon4
    ];
  AXToggleTitleContainerController *toggleContainerCon =
  [[AXToggleTitleContainerController alloc] initWithTogglableViewControllers:viewControllers];
  // You can change ToggleButton's TextColor
  toggleContainerCon.titleToggleButton.tintColor = [UIColor redColor];
  // You can change SubviewList's BackgroundColor.
  toggleContainerCon.subviewListViewController.snapshotTintColor = [UIColor redColor];
  
  // Create New Window with Navigation Controller
  UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  window.rootViewController = [[UINavigationController alloc]
                               initWithRootViewController:toggleContainerCon];
  [window makeKeyAndVisible];
  self.window = window;
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
