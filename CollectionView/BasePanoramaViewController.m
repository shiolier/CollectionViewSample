//
//  BasePanoramaViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/16.
//
//

#import "BasePanoramaViewController.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "CollectionViewCell.h"

@interface BasePanoramaViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FRGWaterfallCollectionViewDelegate>


@end

@implementation BasePanoramaViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Initialize
		
		self.entities = [NSMutableArray array];
		
		FRGWaterfallCollectionViewLayout *collectionViewLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
		collectionViewLayout.delegate = self;
		collectionViewLayout.itemWidth = 150.0f;
		collectionViewLayout.topInset = 10.0f;
		collectionViewLayout.bottomInset = 10.0f;
		collectionViewLayout.stickyHeader = YES;
		
		self.collectionView =
		[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,
														   self.view.frame.size.width, self.view.frame.size.height - 100)
						   collectionViewLayout:collectionViewLayout];
		self.collectionView.delegate = self;
		self.collectionView.dataSource = self;
		self.collectionView.backgroundColor = [UIColor lightGrayColor];
		[self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
		[self.view addSubview:self.collectionView];
	}
	return self;
}

#pragma mark FRGWaterfallCollectionViewDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [CollectionViewCell height:self.entities[indexPath.item]];
}

#pragma mark - UICollectionView
#pragma mark UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"		forIndexPath:indexPath];
	
	cell.entity = self.entities[indexPath.item];
	
	return cell;
}

// セクション毎のセル数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section
{
	return self.entities.count;
}

#pragma mark UICollectionViewDelegate

// セクション数を返す
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

@end
