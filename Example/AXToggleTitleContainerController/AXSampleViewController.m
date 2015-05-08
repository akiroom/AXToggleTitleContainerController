//
//  AXSampleViewController.m
//  AXToggleTitleContainerController
//

#import "AXSampleViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <LoremIpsum/LoremIpsum.h>

@interface AXSampleViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation AXSampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Lorem ipsum text
  _label.text = [LoremIpsum paragraphsWithNumber:4];

  // Lorem ipsum image
  NSString *loremImageURLStr =
  [NSString stringWithFormat:@"%@?dummy=%@",
   [[LoremIpsum URLForPlaceholderImageWithSize:_imageView.bounds.size] absoluteString],
   [self.title substringToIndex:3]];
  NSURL *loremImageURL = [NSURL URLWithString:loremImageURLStr];
  UIImage *emptyImage = [[UIImage alloc] init];
  [_imageView sd_setImageWithURL:loremImageURL placeholderImage:emptyImage options:SDWebImageCacheMemoryOnly];
}

@end
