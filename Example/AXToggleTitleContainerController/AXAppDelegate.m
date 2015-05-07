//
//  AXAppDelegate.m
//  AXToggleTitleContainerController
//

#import "AXAppDelegate.h"
#import "AXDummyViewController.h"

@implementation AXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  AXDummyViewController *dummyViewCon1 = [[AXDummyViewController alloc] init];
  
  UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  window.rootViewController = dummyViewCon1;
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
