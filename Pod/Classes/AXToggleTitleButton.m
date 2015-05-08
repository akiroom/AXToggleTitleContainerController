//
//  AXToggleTitleButton.m
//  Pods
//

#import "AXToggleTitleButton.h"

@implementation AXToggleTitleButton {
  UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.font = [UIFont boldSystemFontOfSize:18.0];
    self.userInteractionEnabled = YES;

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.clipsToBounds = YES;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.layer.cornerRadius = 4.0;
    [self addSubview:_titleLabel];
    
    [self updateTitleLabel];
  }
  return self;
}

- (void)layoutSubviews
{
  if (_freezeLabelWidth == NO) {
    [_titleLabel sizeToFit];
    CGRect moreBounds = CGRectInset(_titleLabel.bounds, -4.0, -4.0);
    [_titleLabel setBounds:(CGRect){
      CGPointZero,
      MIN(CGRectGetWidth(moreBounds), CGRectGetWidth(self.bounds)),
      CGRectGetHeight(moreBounds)
    }];
  }
  [_titleLabel setCenter:(CGPoint){
    (CGRectGetMidX(self.bounds)
     - CGRectGetMinX(self.frame) / 2
     + (CGRectGetWidth(self.superview.frame) - CGRectGetMaxX(self.frame)) / 2
     + 0.0),
    CGRectGetMidY(self.bounds)
  }];
}

#pragma mark - Property

- (void)setHighlighted:(BOOL)highlighted
{
  [super setHighlighted:highlighted];
  _titleLabel.backgroundColor = (highlighted ?
                                 [UIColor colorWithWhite:0.0 alpha:0.2] :
                                 [UIColor clearColor]);
}

- (void)setSelected:(BOOL)selected
{
  [super setSelected:selected];
  [self updateTitleLabel];
}

- (void)setTitle:(NSString *)title
{
  if (![_title isEqualToString:title]) {
    _title = [title copy];
    [self updateTitleLabel];
  }
}

#pragma mark - Private method

- (void)updateTitleLabel
{
  NSMutableDictionary *attributes =
  [@{NSForegroundColorAttributeName : self.tintColor,
     NSFontAttributeName : _font} mutableCopy];
  
  NSString *text = [NSString stringWithFormat:@"%@", (self.title ? self.title : @"")];
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:text
                                                                            attributes:attributes];
  
  [title appendAttributedString:[[NSAttributedString alloc] initWithString:@" "
                                                                attributes:attributes]];

  if (!_chevronUpIcon || !_chevronDownIcon) {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AXToggleTitleContainerController" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *imagePath;
    if (!_chevronUpIcon) {
      imagePath = [bundle pathForResource:@"chevron-up@2x" ofType:@"png"];
      _chevronUpIcon =
      [[UIImage imageWithContentsOfFile:imagePath]
       imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    if (!_chevronDownIcon) {
      imagePath = [bundle pathForResource:@"chevron-down@2x" ofType:@"png"];
      _chevronDownIcon =
      [[UIImage imageWithContentsOfFile:imagePath]
       imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
  }
  
  NSTextAttachment *iconAttachment = [[NSTextAttachment alloc] init];
  iconAttachment.image = (self.isSelected ?
                          self.chevronUpIcon :
                          self.chevronDownIcon);
  NSMutableAttributedString *iconString = [[NSAttributedString attributedStringWithAttachment:iconAttachment] mutableCopy];
  [iconString addAttributes:@{NSBaselineOffsetAttributeName : @(-1)} range:NSMakeRange(0, 1)];
  [title appendAttributedString:iconString];

  _titleLabel.attributedText = title;
  [self setNeedsLayout];
}

@end
