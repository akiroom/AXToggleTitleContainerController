//
//  AXToggleTitleContainerController.h
//  Pods
//

#import <UIKit/UIKit.h>
#import "AXToggleTitleListViewController.h"
#import "AXToggleTitleButton.h"

@interface AXToggleTitleContainerController : UIViewController
@property (readonly, nonatomic) AXToggleTitleListViewController *listViewController;
@property (readonly, nonatomic) AXToggleTitleButton *titleToggleButton;
@property (copy, nonatomic) NSArray *togglableViewControllers;
@property (readonly, nonatomic) UIViewController *selectedViewController;
- (instancetype)initWithTogglableViewControllers:(NSArray *)togglableViewControllers;
@end
