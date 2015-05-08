//
//  AXDummyViewController.m
//  AXToggleTitleContainerController
//

#import "AXDummyViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <LoremIpsum/LoremIpsum.h>

@interface AXDummyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation AXDummyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Lorem ipsum
  _label.text = [LoremIpsum paragraphsWithNumber:4];
  NSString *loremImageURLStr =
  [NSString stringWithFormat:@"%@?dummy=%@",
   [[LoremIpsum URLForPlaceholderImageWithSize:_imageView.bounds.size] absoluteString],
   self.title];
  NSURL *loremImageURL = [NSURL URLWithString:loremImageURLStr];
  UIImage *emptyImage = [[UIImage alloc] init];
  [_imageView sd_setImageWithURL:loremImageURL placeholderImage:emptyImage];
}

@end
