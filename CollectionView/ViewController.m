//
//  ViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/02.
//
//

#import "ViewController.h"
#import "CollectionViewCell.h"

#define CellID @"CollectionViewCell"

@interface ViewController ()

@property UICollectionView *collectionView;
@property UICollectionViewFlowLayout *collectionViewFlowLayout;

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
	
	self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
	// アイテムサイズ
	self.collectionViewFlowLayout.itemSize = CGSizeMake(150, 150);
	// セクションとアイテムの間隔
	self.collectionViewFlowLayout.minimumLineSpacing = 5.0f;
	// アイテム同士の間隔
    self.collectionViewFlowLayout.minimumInteritemSpacing = 10.0f;
	
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
											 collectionViewLayout:self.collectionViewFlowLayout];
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

#pragma mark - UICollectionView
#pragma mark DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID		forIndexPath:indexPath];
	
	cell.numberLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
	
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
}

#pragma mark Delegate

// セクション数を返す
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 5;
}

#pragma mark -

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
