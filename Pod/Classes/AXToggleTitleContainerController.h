//
//  AXToggleTitleContainerController.h
//  Pods
//

#import <UIKit/UIKit.h>
#import "AXToggleTitleListViewController.h"
#import "AXToggleTitleButton.h"

@interface AXToggleTitleContainerController : UIViewController
@property (readonly, nonatomic) AXToggleTitleListViewController *subviewListViewController;
@property (readonly, nonatomic) AXToggleTitleButton *titleToggleButton;
@property (copy, nonatomic) NSArray *viewControllers;
@property (readonly, nonatomic) UIViewController *selectedListViewController;
- (instancetype)initWithViewControllers:(NSArray *)viewControllers;
@end
