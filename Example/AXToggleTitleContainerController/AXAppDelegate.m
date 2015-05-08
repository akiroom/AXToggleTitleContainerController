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
  AXDummyViewController *dummyViewCon1 = [[AXDummyViewController alloc] init];
  dummyViewCon1.title = @"Articles";
  AXDummyViewController *dummyViewCon2 = [[AXDummyViewController alloc] init];
  dummyViewCon2.title = @"Users";
  AXDummyViewController *dummyViewCon3 = [[AXDummyViewController alloc] init];
  dummyViewCon3.title = @"Long Long Title";
  
  NSArray *viewControllers =
  @[
    dummyViewCon1, dummyViewCon2, dummyViewCon3
    ];
  AXToggleTitleContainerController *toggleContainerCon =
  [[AXToggleTitleContainerController alloc] initWithViewControllers:viewControllers];
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
