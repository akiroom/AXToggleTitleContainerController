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
    
    _listViewController = [[AXToggleTitleListViewController alloc] init];
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
  self.navigationItem.titleView = _titleToggleButton;
  _listViewController.delegate = self;
  if (!_didFirstTransition) {
    [self transitionToViewController:[_togglableViewControllers firstObject]];
  }
}

- (void)viewWillAppear:(BOOL)animated
{
  [_titleToggleButton setFrame:self.navigationController.navigationBar.bounds];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)toggleShowingSubviewList:(id)sender
{
  if (_selectedViewController == (id)_listViewController) {
    [self transitionToViewController:_togglableViewControllers[_listViewController.selectedIndex]];
  } else {
    _listViewController.selectedIndex = [_togglableViewControllers indexOfObject:_selectedViewController];
    [self transitionToViewController:_listViewController];
  }
}

#pragma mark - Property

- (void)setTogglableViewControllers:(NSArray *)togglableViewControllers
{
  [_listViewController removeFromParentViewController];
  for (UIViewController *viewCon in _togglableViewControllers) {
    [viewCon removeFromParentViewController];
  }

  _togglableViewControllers = [togglableViewControllers copy];

  NSMutableArray *titles = [NSMutableArray array];
  for (UIViewController *viewCon in _togglableViewControllers) {
    [titles addObject:(viewCon.title ? viewCon.title : @"")];
  }
  _listViewController.subviewTitles = titles;
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
  
  UIViewController *fromViewController = _selectedViewController;
  if (fromViewController == toViewController) {
    return;
  }
  
  if (toViewController == _listViewController) {
    _titleToggleButton.freezeLabelWidth = YES;
    [_listViewController setBackgroundSnapshotWithView:fromViewController.view];
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
  
  _selectedViewController = (id)toViewController;
  if (_selectedViewController.title.length > 0) {
    _titleToggleButton.title = _selectedViewController.title;
  }
  [self.navigationItem setLeftBarButtonItems:_selectedViewController.navigationItem.leftBarButtonItems
                                    animated:YES];
  [self.navigationItem setRightBarButtonItems:_selectedViewController.navigationItem.rightBarButtonItems
                                     animated:YES];
  self.navigationItem.prompt = _selectedViewController.navigationItem.prompt;
  self.navigationItem.hidesBackButton = _selectedViewController.navigationItem.hidesBackButton;
  self.navigationItem.backBarButtonItem = _selectedViewController.navigationItem.backBarButtonItem;
  
  BOOL isShowingSubviewList = (_selectedViewController == (id)_listViewController);
  _titleToggleButton.selected = isShowingSubviewList;
}

@end
