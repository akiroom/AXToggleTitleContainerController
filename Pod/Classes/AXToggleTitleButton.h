//
//  AXToggleTitleButton.h
//  Pods
//

#import <UIKit/UIKit.h>

@interface AXToggleTitleButton : UIControl
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIFont *font;
@property (readonly, nonatomic) UILabel *titleLabel;
@property (nonatomic) BOOL freezeLabelWidth;
@end
