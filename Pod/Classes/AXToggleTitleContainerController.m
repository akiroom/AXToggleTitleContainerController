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
    [self transitionToViewController:_togglableViewControllers[_subviewListViewController.selectedIndex]];
  } else {
    _subviewListViewController.selectedIndex = [_togglableViewControllers indexOfObject:_selectedListViewController];
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
    [titles addObject:(viewCon.title ? viewCon.title : @"")];
  }
  _subviewListViewController.subviewTitles = titles;
}

#pragma mark - Sub view list view controller delegate

- (void)toggleTitleListViewController:(AXToggleTitleListViewController *)toggleTitleListViewController didSelectIndex:(NSInteger)selectedIndex
{
  UIViewController *nextViewController = _togglableViewControllers[selectedIndex];
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
  
  if (toViewController == _subviewListViewController) {
    _titleToggleButton.freezeLabelWidth = YES;
    [_subviewListViewController setBackgroundSnapshotWithView:fromViewController.view];
    self.view.backgroundColor = fromViewController.view.backgroundColor;
  } else {
    _titleToggleButton.freezeLabelWidth = NO;
  }
  
  if (fromViewController) {
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    } completion:^(BOOL finished) {
      [fromViewController removeFromParentViewController];
      [toViewController didMoveToParentViewController:self];
      _isTransitioning = NO;
    }];
  } else {
    [self addChildViewController:toViewController];
    [self.view addSubview:toViewController.view];
    [toViewController didMoveToParentViewController:self];
    _isTransitioning = NO;
  }
  
  _selectedListViewController = (id)toViewController;
  if (_selectedListViewController.title.length > 0) {
    _titleToggleButton.title = _selectedListViewController.title;
  }
  [self.navigationItem setLeftBarButtonItems:_selectedListViewController.navigationItem.leftBarButtonItems
                                    animated:YES];
  [self.navigationItem setRightBarButtonItems:_selectedListViewController.navigationItem.rightBarButtonItems
                                     animated:YES];
  self.navigationItem.prompt = _selectedListViewController.navigationItem.prompt;
  self.navigationItem.hidesBackButton = _selectedListViewController.navigationItem.hidesBackButton;
  self.navigationItem.backBarButtonItem = _selectedListViewController.navigationItem.backBarButtonItem;
  
  BOOL isShowingSubviewList = (_selectedListViewController == (id)_subviewListViewController);
  _titleToggleButton.selected = isShowingSubviewList;
}

@end
