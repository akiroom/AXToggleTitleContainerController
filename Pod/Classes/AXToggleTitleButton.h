//
//  AXToggleTitleButton.h
//  Pods
//

#import <UIKit/UIKit.h>

@interface AXToggleTitleButton : UIControl
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIFont *font;
@property (readonly, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImage *chevronUpIcon;
@property (strong, nonatomic) UIImage *chevronDownIcon;
@property (nonatomic) BOOL freezeLabelWidth;
@end
