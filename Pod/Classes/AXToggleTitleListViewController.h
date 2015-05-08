//
//  AXToggleTitleListViewController.h
//  Pods
//

#import <UIKit/UIKit.h>

extern const CGFloat AXToggleTitleListViewControllerCellHeight;

@class AXToggleTitleListViewController;

@protocol AXToggleTitleListViewControllerDelegate <NSObject>
@optional
- (void)toggleTitleListViewController:(AXToggleTitleListViewController *)toggleTitleListViewController
                       didSelectIndex:(NSInteger)selectedIndex;
@end

@interface AXToggleTitleListViewController : UITableViewController
@property (copy, nonatomic) NSArray *subviewTitles;
@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) UIImage *backgroundSnapshot;
@property (nonatomic) id<AXToggleTitleListViewControllerDelegate> delegate;
@property (strong, nonatomic) UIColor *snapshotTintColor;
- (void)setBackgroundSnapshotWithView:(UIView *)backgroundSnapshotView;
@end
