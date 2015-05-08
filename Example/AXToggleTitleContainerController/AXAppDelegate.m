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
  
  AXDummyViewController *dummyViewCon1 = [[AXDummyViewController alloc] init];
  dummyViewCon1.title = @"Articles";
  item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                       target:nil action:NULL];
  dummyViewCon1.navigationItem.leftBarButtonItem = item;

  AXDummyViewController *dummyViewCon2 = [[AXDummyViewController alloc] init];
  dummyViewCon2.title = @"Users";
  item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                       target:nil action:NULL];
  dummyViewCon2.navigationItem.rightBarButtonItem = item;
  
  AXDummyViewController *dummyViewCon3 = [[AXDummyViewController alloc] init];
  dummyViewCon3.title = @"Super Long of the Long Awesome Title";
  dummyViewCon3.navigationItem.leftBarButtonItem =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                target:nil action:NULL];
  dummyViewCon3.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                target:nil action:NULL];
  
  NSArray *viewControllers =
  @[
    dummyViewCon1, dummyViewCon2, dummyViewCon3
    ];
  AXToggleTitleContainerController *toggleContainerCon =
  [[AXToggleTitleContainerController alloc] initWithTogglableViewControllers:viewControllers];
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
