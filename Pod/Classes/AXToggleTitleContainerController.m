//
//  AXToggleTitleContainerController.m
//  Pods
//

#import "AXToggleTitleContainerController.h"

@interface AXToggleTitleContainerController ()<AXToggleTitleListViewControllerDelegate>
@end

@implementation AXToggleTitleContainerController {
  BOOL _isTransitioning;
  BOOL _didFirstTransition;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    _titleToggleButton = [[AXToggleTitleButton alloc] init];
    [_titleToggleButton setTitle:@"お気に入り"];
    [_titleToggleButton addTarget:self action:@selector(toggleShowingSubviewList:) forControlEvents:UIControlEventTouchUpInside];
    
    _subviewListViewController = [[AXToggleTitleListViewController alloc] init];
  }
  return self;
}

- (instancetype)initWithTogglableViewControllers:(NSArray *)togglableViewControllers
{
  if (self = [self initWithNibName:nil bundle:nil]) {
    [self setTogglableViewControllers:togglableViewControllers];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [_titleToggleButton setFrame:self.navigationController.navigationBar.bounds];
  self.navigationItem.titleView = _titleToggleButton;
  _subviewListViewController.delegate = self;
  if (!_didFirstTransition) {
    [self transitionToViewController:[_togglableViewControllers firstObject]];
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)toggleShowingSubviewList:(id)sender
{
  if (_selectedListViewController == (id)_subviewListViewController) {
    [self transitionToViewController:self.childViewControllers[_subviewListViewController.selectedIndex]];
  } else {
    _subviewListViewController.selectedIndex = [self.childViewControllers indexOfObject:_selectedListViewController];
    [self transitionToViewController:_subviewListViewController];
  }
}

#pragma mark - Property

- (void)setTogglableViewControllers:(NSArray *)togglableViewControllers
{
  [_subviewListViewController removeFromParentViewController];
  for (UIViewController *viewCon in _togglableViewControllers) {
    [viewCon removeFromParentViewController];
  }
  
  _togglableViewControllers = [togglableViewControllers copy];
  
  NSMutableArray *titles = [NSMutableArray array];
  for (UIViewController *viewCon in _togglableViewControllers) {
    [self addChildViewController:viewCon];
    [titles addObject:(viewCon.title ? viewCon.title : @"")];
  }
  _subviewListViewController.subviewTitles = titles;
  [self addChildViewController:_subviewListViewController];
}

#pragma mark - Sub view list view controller delegate

- (void)toggleTitleListViewController:(AXToggleTitleListViewController *)toggleTitleListViewController didSelectIndex:(NSInteger)selectedIndex
{
  UIViewController *nextViewController = self.childViewControllers[selectedIndex];
  [self transitionToViewController:nextViewController];
}

#pragma mark - Private method

- (void)transitionToViewController:(UIViewController *)toViewController
{
  if (_isTransitioning) {
    return;
  }
  _isTransitioning = YES;
  _didFirstTransition = YES;
  
  UIViewController *fromViewController = _selectedListViewController;
  if (fromViewController == toViewController) {
    return;
  }
  
  [fromViewController beginAppearanceTransition:NO animated:NO];
  [toViewController beginAppearanceTransition:YES animated:NO];
  
  toViewController.view.frame = self.view.bounds;
  
  if (toViewController == _subviewListViewController) {
    [_subviewListViewController setBackgroundSnapshotWithView:fromViewController.view];
  }
  if (fromViewController.view && toViewController.view) {
    [UIView transitionFromView:fromViewController.view toView:toViewController.view duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
      [fromViewController.view removeFromSuperview];
      _isTransitioning = NO;
    }];
  } else {
    [fromViewController.view removeFromSuperview];
    [self.view addSubview:toViewController.view];
    _isTransitioning = NO;
  }
  
  [fromViewController endAppearanceTransition];
  [toViewController endAppearanceTransition];
  
  _selectedListViewController = (id)toViewController;
  if (_selectedListViewController.title.length > 0) {
    _titleToggleButton.title = _selectedListViewController.title;
  }
  BOOL isShowingSubviewList = (_selectedListViewController == (id)_subviewListViewController);
  _titleToggleButton.selected = isShowingSubviewList;
}

@end
