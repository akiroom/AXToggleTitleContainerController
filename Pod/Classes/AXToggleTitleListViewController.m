//
//  AXToggleTitleListViewController.m
//  Pods
//

#import "AXToggleTitleListViewController.h"
#import <UIImageEffects/UIImage+ImageEffects.h>
#import "AXToggleTitleListCell.h"

const CGFloat AXToggleTitleListViewControllerCellHeight = 64.0;

@interface AXToggleTitleListViewController ()

@end

@implementation AXToggleTitleListViewController{
  UIImageView *_tableViewBackgroundView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    _snapshotTintColor = [UIColor colorWithRed:0.0
                                         green:122.0 / 255.0
                                          blue:1.0
                                         alpha:1.0];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = self.tableView;
  [tableView registerClass:[AXToggleTitleListCell class]
    forCellReuseIdentifier:NSStringFromClass([AXToggleTitleListCell class])];
  [tableView setSeparatorInset:UIEdgeInsetsMake(0.0, AXToggleTitleListViewControllerCellHeight, 0.0, 0.0)];
  [tableView setSeparatorColor:[UIColor whiteColor]];
  [tableView setTableFooterView:[[UIView alloc] init]];
  
  _tableViewBackgroundView = [[UIImageView alloc] initWithFrame:tableView.bounds];
  _tableViewBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
  [tableView setBackgroundView:_tableViewBackgroundView];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];

  UITableView *tableView = self.tableView;
  tableView.contentInset = UIEdgeInsetsMake([self.parentViewController.topLayoutGuide length],
                                            0.0,
                                            [self.parentViewController.bottomLayoutGuide length],
                                            0.0);
  tableView.scrollIndicatorInsets = tableView.contentInset;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Property

- (void)setBackgroundSnapshot:(UIImage *)backgroundSnapshot
{
  if (_backgroundSnapshot != backgroundSnapshot) {
    _backgroundSnapshot = backgroundSnapshot;
    
    _tableViewBackgroundView.image = [backgroundSnapshot applyTintEffectWithColor:_snapshotTintColor];
  }
}

- (void)setBackgroundSnapshotWithView:(UIView *)backgroundSnapshotView
{
  UIGraphicsBeginImageContext(backgroundSnapshotView.bounds.size);
  [backgroundSnapshotView drawViewHierarchyInRect:backgroundSnapshotView.bounds
                               afterScreenUpdates:NO];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  self.backgroundSnapshot = image;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
  if (_selectedIndex != selectedIndex) {
    _selectedIndex = selectedIndex;
    [self.tableView reloadData];
  }
}

- (void)setSubviewTitles:(NSArray *)subviewTitles
{
  if (_subviewTitles != subviewTitles) {
    _subviewTitles = [subviewTitles copy];
    [self.tableView reloadData];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _subviewTitles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  AXToggleTitleListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AXToggleTitleListCell class])
                                                             forIndexPath:indexPath];
  if (indexPath.row == _selectedIndex) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  cell.textLabel.text = _subviewTitles[indexPath.row];
  return cell;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return AXToggleTitleListViewControllerCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = indexPath.row;
  if (0 <= index && index < _subviewTitles.count) {
    if ([_delegate respondsToSelector:@selector(toggleTitleListViewController:didSelectIndex:)]) {
      [_delegate toggleTitleListViewController:self didSelectIndex:indexPath.row];
    }
  }
}

@end
