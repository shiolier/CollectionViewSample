//
//  ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "InfinitePagingView.h"
#import "Panorama1ViewController.h"
#import "Panorama2ViewController.h"
#import "Panorama3ViewController.h"
#import "Panorama4ViewController.h"
#import "Panorama5ViewController.h"

#define CellID @"CollectionViewCell"

@interface ViewController () // <UICollectionViewDelegate, UICollectionViewDataSource, FRGWaterfallCollectionViewDelegate, UIScrollViewDelegate>
<UIScrollViewDelegate>

//@property (nonatomic) UICollectionView *collectionView;
//@property (nonatomic) NSMutableArray *collectionItems;
@property (nonatomic) UIView *buttonScrollContentView;
@property (nonatomic) UIView *scrollContentView;
@property (nonatomic) NSMutableArray *collectionViewControllers;
@property (nonatomic) int currentPage;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
//	[self changeCollectionItems:0];

	[self.view addSubview:self.buttonScrollView];
	[self.view addSubview:self.photoScrollView];
	
#pragma mark - 無限のおまじない
	/*
	// http://qiita.com/caesar_cat/items/f6a60b6bb6880ea18139
	InfinitePagingView *infinitePagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
	infinitePagingView.pageSize = CGSizeMake(self.view.frame.size.width / 2, infinitePagingView.frame.size.height);
	for (int i = 0; i < 5; i++) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
		button.userInteractionEnabled = YES;
		button.tag = i;
		[button setTitle:[NSString stringWithFormat:@"更新%d", i] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor colorWithRed:0 / 255.0f green:128 / 255.0f blue:255 / 255.0f alpha: 1.0f] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor colorWithRed:0 / 255.0f green:128 / 255.0f blue:255 / 255.0f alpha: 0.5f] forState:UIControlStateHighlighted];
		[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
		[infinitePagingView	addPageView:button];
	}
	[self.view addSubview:infinitePagingView];
	 */
	
}

#pragma mark - instance

-(UIScrollView *)buttonScrollView {
	if (!_buttonScrollView) {
		_buttonScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
		_buttonScrollView.delegate = self;
		// スクロール方法をページ単位にする
		_buttonScrollView.pagingEnabled = YES;
		[_buttonScrollView addSubview:self.buttonContentView];
		_buttonScrollView.contentSize = self.buttonContentView.frame.size;
	}
	return _buttonScrollView;
}

-(UIView *)buttonContentView {
	if (!_buttonContentView) {
		int pageNum = 5;
		CGSize onePageSize = _buttonScrollView.frame.size;
		CGRect buttonContentRect = CGRectMake(0, 0, onePageSize.width * pageNum, onePageSize.height);
		_buttonContentView = [[UIView alloc]initWithFrame:buttonContentRect];
		
		CGFloat selfViewWidth = self.view.frame.size.width;
		CGFloat selfViewWidthHalf = selfViewWidth / 2;
		
		for (int i = 0; i < pageNum; i++) {
			UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
			button.center = CGPointMake(selfViewWidthHalf + (selfViewWidth * i), _buttonContentView.center.y);
			button.tag = i + 800;
			[button setTitle:[NSString stringWithFormat:@"更新%d", i] forState:UIControlStateNormal];
			[button setTitleColor:[UIColor colorWithRed:0 / 255.0f green:128 / 255.0f blue:255 / 255.0f alpha: 1.0f] forState:UIControlStateNormal];
			[button setTitleColor:[UIColor colorWithRed:0 / 255.0f green:128 / 255.0f blue:255 / 255.0f alpha: 0.5f] forState:UIControlStateHighlighted];
			[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
			[_buttonContentView	addSubview:button];
		}
	}
	return _buttonContentView;
}

-(UIScrollView *)photoScrollView {
	if (!_photoScrollView) {
		_photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
		_photoScrollView.delegate = self;
		// スクロール方法をページ単位にする
		_photoScrollView.pagingEnabled = YES;
		[_photoScrollView addSubview:self.photoContentView];
		_photoScrollView.contentSize = self.photoContentView.frame.size;
	}
	return _photoScrollView;
}

-(UIView *)photoContentView {
	if (!_photoContentView) {
		_photoContentView = [UIView new];
		for (int i = 0; i < self.collectionViewControllers.count; i++) {
			UIViewController *vc = self.collectionViewControllers[i];
            [vc willMoveToParentViewController:self];
            [self addChildViewController:vc];
            [_photoContentView addSubview:vc.view];
            [vc didMoveToParentViewController:self];
            
            vc.view.frame = CGRectMake(_photoScrollView.bounds.size.width * i, 0,
                                       _photoScrollView.bounds.size.width, _photoScrollView.bounds.size.height);
            
            CGRect r = _photoContentView.frame;
            r.size.width = vc.view.frame.size.width+vc.view.frame.origin.x;
            _photoContentView.frame = r;
		}
	}
	return _photoContentView;
}

-(NSMutableArray *)collectionViewControllers {
	if (!_collectionViewControllers) {
		_collectionViewControllers = @[
									   [Panorama1ViewController new],
									   [Panorama2ViewController new],
									   [Panorama3ViewController new],
									   [Panorama4ViewController new],
									   [Panorama5ViewController new],
									   ].mutableCopy;
	}
	return _collectionViewControllers;
}

#pragma mark -

- (void)changeFromViewControllerNumber:(int)fromNum
				toViewControllerNumber:(int)toNum
{
	if (fromNum == toNum) {
		return;
	}
	
	self.currentPage = toNum;
	
	UIViewController *fromVC = self.collectionViewControllers[toNum];
	UIViewController *toVC = self.collectionViewControllers[fromNum];
	
	// 古いViewControllerに取り除かれようとしていることを通知する
	[fromVC willMoveToParentViewController:nil];
	
	CGFloat width  = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height - 100;
	
	CGPoint fromEndPos;
	CGPoint toStartPos;
	if (fromNum < toNum) {
		fromEndPos = CGPointMake(0 - self.view.frame.size.width, 100);
		toStartPos = CGPointMake(self.view.frame.size.width, 100);
	} else {
		fromEndPos = CGPointMake(self.view.frame.size.width, 100);
		toStartPos = CGPointMake(0 - self.view.frame.size.width, 100);
	}
	
	[self addChildViewController:toVC];
	toVC.view.frame = CGRectMake(toStartPos.x, toStartPos.y,
								 width, height);
	
	[toVC didMoveToParentViewController:self];
	
	[self transitionFromViewController:fromVC
					  toViewController:toVC
							  duration:0.25
							   options:0
							animations:^{
								toVC.view.frame = CGRectMake(0, 100,
															 width, height);
								fromVC.view.frame = CGRectMake(fromEndPos.x, fromEndPos.y,
															   width, height);
							}
							completion:^(BOOL finished) {
								[fromVC.view removeFromSuperview];
								[fromVC removeFromParentViewController];
								[toVC didMoveToParentViewController:self];
							}];
}
- (void)addPanoramaViewController:(UIViewController *)viewController
{
	viewController.view.frame = CGRectMake(0 - self.view.frame.size.width, 100,
										   self.view.frame.size.width, self.view.frame.size.height - 100);
	[self addChildViewController:viewController];
	// [self.view addSubview:viewController.view];
	[viewController didMoveToParentViewController:self];
	[self.collectionViewControllers addObject:viewController];
}

- (void)addPanoramaViewController:(UIViewController *)viewController
						  pageNum:(int)pageNum
{
	viewController.view.frame = CGRectMake(0 - self.view.frame.size.width, 100,
										   self.view.frame.size.width, self.view.frame.size.height - 100);
	[self addChildViewController:viewController];
	[self.view addSubview:viewController.view];
	[viewController didMoveToParentViewController:self];
	[self.collectionViewControllers addObject:viewController];
}

- (void)buttonAction:(UIButton *)button
{
	NSLog(@"\ncurrent : %d\nnext : %d",self.currentPage, button.tag);
	
	CGRect frame = self.photoScrollView.bounds;
    frame.origin.x = frame.size.width * (button.tag - 800);
    [self.photoScrollView scrollRectToVisible:frame animated:YES];
	
	// [self animationFromViewControllerNumber:self.currentPage toViewControllerNumber:button.tag];
//	[self changeFromViewControllerNumber:self.currentPage toViewControllerNumber:button.tag];
}

/*
#pragma mark - UICollectionView
#pragma mark UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID		forIndexPath:indexPath];
	
	cell.collectionItem = self.collectionItems[indexPath.item];
	
	cell.label.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
	cell.imageView.image = [UIImage imageNamed:@"sample_image"];
	
	if (indexPath.section == 0) {
        cell.backgroundColor =[UIColor redColor];
    } else if (indexPath.section == 1) {
        cell.backgroundColor =[UIColor greenColor];
    } else {
        cell.backgroundColor =[UIColor blueColor];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	return cell;
}

// セクション毎のセル数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section
{
	if (section == 0) {
		return 3;
	} else if (section == 1) {
		return 5;
	} else if (section == 2) {
		return 10;
	} else if (section == 3) {
		return 20;
	} else {
		return 30;
	}
	return self.collectionItems.count;
}

#pragma mark UICollectionViewDelegate

// セクション数を返す
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

#pragma mark FRGWaterfallCollectionViewDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [CollectionViewCell height:self.collectionItems[indexPath.item]];
}
*/

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// NSLog(@"\nX:%f\nY:%f", scrollView.contentOffset.x, scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate
{
	// NSLog(@"\nX:%f\nY:%f", scrollView.contentOffset.x, scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	// NSLog(@"\nX:%f\nY:%f", scrollView.contentOffset.x, scrollView.contentOffset.y);
	int currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
	NSLog(@"currentPage = %d", currentPage);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
