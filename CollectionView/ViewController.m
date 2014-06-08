//
//  ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "CollectionItem.h"
#import "FRGWaterfallCollectionViewLayout.h"

#define CellID @"CollectionViewCell"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FRGWaterfallCollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *collectionItems;
@property (nonatomic) UIView *scrollContentView;

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
	
//	UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
//	// アイテムサイズ
//	collectionViewFlowLayout.itemSize = CGSizeMake(150, 150);
//	// セクションとアイテムの間隔
//	collectionViewFlowLayout.minimumLineSpacing = 5.0f;
//	// アイテム同士の間隔
//    collectionViewFlowLayout.minimumInteritemSpacing = 10.0f;
	
	[self changeCollectionItems:0];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
	scrollView.delegate = self;
	// スクロール方法をページ単位にする
	scrollView.pagingEnabled = YES;
	[self.view addSubview:scrollView];
	
	int pageNum = 3;
	CGSize onePageSize = scrollView.frame.size;
	CGRect contentRect = CGRectMake(0, 0, onePageSize.width * pageNum, onePageSize.height);
	
	self.scrollContentView = [[UIView alloc] initWithFrame:contentRect];
	[scrollView addSubview:self.scrollContentView];
	
	// スクロールするコンテントサイズを指定する
	scrollView.contentSize = self.scrollContentView.frame.size;
	// スクロール画面の初期位置を指定する
	scrollView.contentOffset = CGPointZero;
	
	FRGWaterfallCollectionViewLayout *collectionViewLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
	collectionViewLayout.delegate = self;
	collectionViewLayout.itemWidth = 150.0f;
	collectionViewLayout.topInset = 10.0f;
	collectionViewLayout.bottomInset = 10.0f;
	collectionViewLayout.stickyHeader = YES;
	
	self.collectionView =
	[[UICollectionView alloc] initWithFrame:CGRectMake(0, 100,
													   self.view.frame.size.width, self.view.frame.size.height - 100)
					   collectionViewLayout:collectionViewLayout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	// self.collectionView.backgroundColor = [UIColor whiteColor];
	[self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CellID];
	[self.view addSubview:self.collectionView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeCollectionItems:(int)pageNum
{
	self.collectionItems = [NSMutableArray array];
	int itemNum = 10 * (pageNum + 1);
	for (int i = 0; i < itemNum; i++) {
		CollectionItem *item = [[CollectionItem alloc] init];
		item.text = [NSString stringWithFormat:@"%d", i];
		int imageNumber = arc4random() % 5 + 1;
		item.image_name = [NSString stringWithFormat:@"sample_image_%d", imageNumber];
		[self.collectionItems addObject:item];
	}
	[self.collectionView reloadData];
}

#pragma mark - UICollectionView
#pragma mark UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID		forIndexPath:indexPath];
	
	cell.collectionItem = self.collectionItems[indexPath.item];
	
//	cell.label.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
//	cell.imageView.image = [UIImage imageNamed:@"sample_image"];
	
//	if (indexPath.section == 0) {
//        cell.backgroundColor =[UIColor redColor];
//    } else if (indexPath.section == 1) {
//        cell.backgroundColor =[UIColor greenColor];
//    } else {
//        cell.backgroundColor =[UIColor blueColor];
//    }
	
	cell.backgroundColor = [UIColor whiteColor];
	
	return cell;
}

// セクション毎のセル数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section
{
//	if (section == 0) {
//		return 3;
//	} else if (section == 1) {
//		return 5;
//	} else if (section == 2) {
//		return 10;
//	} else if (section == 3) {
//		return 20;
//	} else {
//		return 30;
//	}
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
	int page = scrollView.contentOffset.x / self.view.frame.size.width;
	NSLog(@"page = %d", page);
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
