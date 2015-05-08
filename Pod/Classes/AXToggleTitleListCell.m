//
//  AXToggleTitleListCell.m
//  Pods
//

#import "AXToggleTitleListCell.h"

@implementation AXToggleTitleListCell {
  BOOL _highlighted;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self configureULSSubviewListCell];
  }
  return self;
}

- (void)awakeFromNib {
  [self configureULSSubviewListCell];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [self.textLabel sizeToFit];
  self.tintColor = [UIColor colorWithWhite:1.0 alpha:0.2];

  CGRect labelBounds = self.textLabel.bounds;
  CGRect textFrame = CGRectOffset(labelBounds,
                                  self.separatorInset.left,
                                  CGRectGetHeight(self.bounds) - CGRectGetHeight(labelBounds) - 8.0);
  
  // Accessory view
  UIButton *accessoryButton;
  for (UIView *button in self.subviews) {
    if ([button isKindOfClass:[UIButton class]]) {
      accessoryButton = (id)button;
      button.center = (CGPoint){
        CGRectGetWidth(self.bounds) - CGRectGetWidth(button.frame) - 8.0,
        CGRectGetMidY(textFrame)//CGRectGetHeight(self.bounds) - CGRectGetHeight(button.frame)
      };
      
      button.tintColor = self.textLabel.textColor;
      break;
    }
  }
  
  // Text label
  if (accessoryButton) {
    textFrame.size.width = (CGRectGetMinX(accessoryButton.frame) -
                            self.separatorInset.left -
                            8.0);
  } else {
    textFrame.size.width = MIN(textFrame.size.width,
                               CGRectGetWidth(self.bounds) -
                               self.separatorInset.left -
                               8.0);
  }
  [self.textLabel setFrame:textFrame];
}

- (void)configureULSSubviewListCell
{
  self.backgroundColor = [UIColor clearColor];
  self.tintColor = [UIColor whiteColor];
  self.textLabel.textColor = [UIColor whiteColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
  if (_highlighted != highlighted) {
    _highlighted = highlighted;
    
    self.backgroundColor = (highlighted ?
                            self.tintColor :
                            [UIColor clearColor]
                            );
    self.contentView.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
  }
}

@end
